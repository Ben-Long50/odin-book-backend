import { body, validationResult } from 'express-validator';
import bcrypt from 'bcryptjs';
import randomstring from 'randomstring';
import userServices from '../services/userServices.js';
import profileServices from '../services/profileServices.js';

const userController = {
  getUsers: async (req, res) => {
    try {
      const users = await userServices.getAllUsers();
      res.json(users);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  getUserById: async (req, res) => {
    try {
      const user = await userServices.getUserById(req.params.id);
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
      res.json(user);
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
        const user = await userServices.getUserByEmail(value);
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
          const newUser = await userServices.createUser(userData);

          const defaultProfile = await profileServices.createOrUpdateProfile(
            {
              id: 'null',
              username: newUser.email,
              petName: 'Default',
              active: true,
            },
            newUser.id,
          );
          res.status(200).json({ newUser, defaultProfile });
        } catch (error) {
          res.status(500).json({ error: error.message });
        }
      }
    },
  ],

  createGuestUser: async (req, res, next) => {
    try {
      const uniqueIdentifier = randomstring.generate({
        length: 8,
        charset: 'numeric',
      });

      const hashedPassword = await bcrypt.hash(uniqueIdentifier, 10);
      const guestData = {
        firstName: 'Human',
        lastName: uniqueIdentifier,
        email: `Human${uniqueIdentifier}@pawprint.com`,
        password: hashedPassword,
      };
      const newGuestUser = await userServices.createGuestUser(guestData);

      await profileServices.createOrUpdateProfile(
        {
          id: 'null',
          username: `${newGuestUser.firstName}_${newGuestUser.lastName}`,
          petName: 'Default',
          active: true,
        },
        newGuestUser.id,
      );
      req.body.email = newGuestUser.email;
      req.body.password = uniqueIdentifier;
      next();
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteUser: async (req, res) => {
    try {
      const userId = req.userId || req.user.id;
      const user = await userServices.deleteUserById(userId);
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
      res.status(200).json({ user, message: 'Successfully deleted user' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteExpiredGuests: async () => {
    try {
      const result = await userServices.deleteExpiredGuests();
      console.log(`Deleted ${result.count} expired guests`);
    } catch (error) {
      console.error(error.message);
    }
  },

  authenticateUser: [
    body('email', 'Email does not exist')
      .trim()
      .escape()
      .custom(async (value) => {
        const user = await userServices.getUserByEmail(value);
        if (user && user.googleId) {
          throw new Error(
            'An account with this email already exists using the Google sign in option',
          );
        } else if (user && user.facebookId) {
          throw new Error(
            'An account with this email already exists using the Facebook sign in option',
          );
        } else if (!user) {
          throw new Error('An account using this email does not exist');
        }
        return true;
      }),
    body('password', 'Incorrect password')
      .trim()
      .escape()
      .custom(async (value, { req }) => {
        const user = await userServices.getUserByEmail(req.body.email);
        if (!user || user.facebookId) {
          return false;
        }
        const match = await bcrypt.compare(value, user.password);
        if (!match) {
          throw new Error('Incorrect password');
        }
        return true;
      }),
    (req, res, next) => {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        res.status(400).json(errors.array());
      } else {
        next();
      }
    },
  ],
};

export default userController;
