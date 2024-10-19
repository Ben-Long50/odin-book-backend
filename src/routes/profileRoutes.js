import express from 'express';
import cors from 'cors';
import profileController from '../controllers/profileController.js';
import { verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.post(
  '/profile',
  verifyAuthentication,
  profileController.createOrUpdateProfile,
);

router.get('/profiles', verifyAuthentication, profileController.getProfiles);

router.get(
  '/profile',
  verifyAuthentication,
  profileController.getActiveProfile,
);

router.put(
  '/profile',
  verifyAuthentication,
  profileController.setActiveProfile,
);

router.get('/profile/:id', profileController.getProfile);

router.delete(
  '/profile/:id',
  verifyAuthentication,
  profileController.deleteProfile,
);

router.post(
  '/profile/:id/follow',
  verifyAuthentication,
  profileController.followProfile,
);

router.delete(
  '/profile/:id/follow',
  verifyAuthentication,
  profileController.unfollowProfile,
);

router.get('/profile/:id/posts', profileController.getPosts);

router.post(
  '/profile/:id/post',
  verifyAuthentication,
  profileController.createPost,
);

export default router;
