import { body, validationResult } from 'express-validator';
import profileServices from '../services/profileServices.js';

const profileController = {
  getProfiles: async (req, res) => {
    try {
      const profiles = await profileServices.getProfiles();
      if (!profiles) {
        return res.status(404).json({ error: 'No profiles found' });
      }
      res.json(profiles);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  createProfile: async (req, res) => {
    try {
      const profile = await profileServices.createProfile(
        req.body,
        req.user.id,
      );
      res.json(profile);
    } catch (error) {
      res.status(500).json({ message: 'Failed to create profile' });
    }
  },

  setProfileActive: async (req, res) => {
    try {
      const activeProfile = await profileServices.getActiveProfile();
      res.json(activeProfile);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  createUser: [
    body('firstName', 'First name must be a minimum of 2 characters')
      .trim()
      .isLength({ min: 2 })
      .escape(),
    body('lastName', 'Last name must be a minimum of 2 characters')
      .trim()
      .isLength({ min: 2 })
      .escape(),
    body('email')
      .trim()
      .escape()
      .custom(async (value) => {
        const user = await profileServices.getUserByEmail(value);
        if (user && user.facebookId) {
          throw new Error(
            'An account with this email already exists using the Facebook sign in option',
          );
        } else if (user) {
          throw new Error('An account with this email already exists');
        }
        return true;
      }),
    body('password', 'Password must be a minimum of 3 characters')
      .trim()
      .isLength({ min: 6 })
      .escape(),
    body('confirmPassword', 'Passwords must match')
      .trim()
      .escape()
      .custom((value, { req }) => {
        if (value !== req.body.password) {
          return false;
        }
        return true;
      }),

    async (req, res) => {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        res.status(400).json(errors.array());
      } else {
        try {
          const hashedPassword = await bcrypt.hash(req.body.password, 10);
          const userData = {
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            email: req.body.email,
            password: hashedPassword,
          };
          const newUser = await profileServices.createUser(userData);
          res.status(200).json(newUser);
        } catch (error) {
          res.status(500).json({ error: error.message });
        }
      }
    },
  ],
};

export default profileController;
