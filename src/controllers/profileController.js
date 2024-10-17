import { body, validationResult } from 'express-validator';
import profileServices from '../services/profileServices.js';
import upload from '../utils/multer.js';
import { uploadToCloudinary } from '../utils/cloudinary.js';
import notificationServices from '../services/notificationServices.js';

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
    upload.single('image'),
    uploadToCloudinary,
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
          console.log(req.body);

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

  getProfile: async (req, res) => {
    try {
      const profile = await profileServices.getProfile(req.params.id);
      res.status(200).json({ profile });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  },

  followProfile: async (req, res) => {
    try {
      await profileServices.followProfile(req.body.activeId, req.params.id);
      await notificationServices.createFollowNotification(
        req.body.activeId,
        req.params.id,
      );
      res.status(200).json({ message: 'Successfully followed profile' });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  },

  unfollowProfile: async (req, res) => {
    try {
      console.log(req.body.activeId, req.params.id);

      await profileServices.unfollowProfile(req.body.activeId, req.params.id);
      res.status(200).json({ message: 'Successfully unfollowed profile' });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  },

  getPosts: async (req, res) => {
    try {
      const posts = await profileServices.getPosts(req.params.id);
      res.status(200).json({ posts, message: 'Successfully fetched posts' });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  },

  createPost: [
    upload.single('image'),
    uploadToCloudinary,
    body('caption', 'Caption must be less than 150 characters')
      .trim()
      .isLength({ max: 150 })
      .escape(),
    async (req, res) => {
      const errors = validationResult(req);

      if (!errors.isEmpty()) {
        res.status(400).json(errors.array());
      } else {
        try {
          const post = await profileServices.createPost(
            req.body,
            req.params.id,
          );
          res.status(200).json({ post, message: 'Successfully created post' });
        } catch (error) {
          res.status(500).json({ message: error.message });
        }
      }
    },
  ],
};

export default profileController;
