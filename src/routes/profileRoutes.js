import express from 'express';
import cors from 'cors';
import profileController from '../controllers/profileController.js';
import { verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.post(
  '/profile',
  cors({
    origin: 'http://localhost:5173',
    credentials: true,
  }),
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

router.delete(
  '/profile/:id',
  verifyAuthentication,
  profileController.deleteProfile,
);

router.get('/profile/:id/follows', profileController.getFollows);

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
