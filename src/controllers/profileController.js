import { body, validationResult } from 'express-validator';
import profileServices from '../services/profileServices.js';

const profileController = {
  getProfiles: async (req, res) => {
    try {
      const profiles = await profileServices.getProfiles(req.user.id);
      if (!profiles) {
        return res.status(404).json({ error: 'No profiles found' });
      }
      res.json({ profiles, message: 'Successfully fetched user profiles' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  createOrUpdateProfile: [
    body('username', 'Username must be a minimum of 2 characters')
      .trim()
      .isLength({ min: 2 })
      .escape(),
    body('petName', 'Pet name must be a minimum of 2 characters')
      .trim()
      .isLength({ min: 2 })
      .escape(),
    async (req, res) => {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        res.status(400).json(errors.array());
      } else {
        try {
          const profile = await profileServices.createOrUpdateProfile(
            req.body,
            req.user.id,
          );
          if (profile && req.body.id) {
            res.status(200).json({ message: 'Successfully updated profile' });
          } else {
            res.status(200).json({ message: 'Successfully created profile' });
          }
        } catch (error) {
          res.status(500).json({ message: error.message });
        }
      }
    },
  ],

  getActiveProfile: async (req, res) => {
    try {
      const activeProfile = await profileServices.getActiveProfile(req.user.id);

      res.json({
        activeProfile,
        message: 'Successfully fetched active profile',
      });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  },

  setActiveProfile: async (req, res) => {
    try {
      const activeProfile = await profileServices.setActiveProfile(
        req.user.id,
        req.body.id,
      );
      res.status(200).json({
        activeProfile,
        message: 'Successfully changed the active profile',
      });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  },

  deleteProfile: async (req, res) => {
    try {
      await profileServices.deleteProfile(req.params.id);
      res.status(200).json({ message: 'Successfully deleted profile' });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  },
};

export default profileController;
