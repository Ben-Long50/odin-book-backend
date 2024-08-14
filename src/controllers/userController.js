import { body, validationResult } from 'express-validator';
import bcrypt from 'bcryptjs';
import userServices from '../services/userService.js';

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
        if (user) {
          throw new Error('This email is already in use');
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
          res.status(200).json(newUser);
        } catch (error) {
          res.status(500).json({ error: error.message });
        }
      }
    },
  ],

  authenticateUser: [
    body('email', 'Email does not exist')
      .trim()
      .escape()
      .custom(async (value) => {
        const user = await userServices.getUserByEmail(value);
        if (!user) {
          throw new Error('Username does not exist');
        }
        return true;
      }),
    body('password', 'Incorrect password')
      .trim()
      .escape()
      .custom(async (value, { req }) => {
        const user = await userServices.getUserByEmail(req.body.email);
        if (!user) {
          return false;
        }
        const match = await bcrypt.compare(value, user.password);
        if (!match) {
          throw new Error('Incorrect password');
        }
        return true;
      }),

    async (req, res) => {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        res.status(400).json(errors.array());
      }

      try {
        const user = await userServices.getUserByEmail(req.body.email);
        jwt.sign(
          { user },
          process.env.JWT_SECRET,
          {
            expiresIn: '4h',
          },
          (err, token) => {
            if (err) {
              res.status(500).json({ message: 'Error generating token' });
            }
            res.status(200).json({
              token,
              user,
            });
          },
        );
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
    },
  ],
};

export default userController;
