import express from 'express';
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
  '/profiles/:profileId',
  verifyAuthentication,
  profileController.setActiveProfile,
);

router.get('/profile/:id', profileController.getProfile);

router.delete(
  '/profile/:id',
  verifyAuthentication,
  profileController.deleteProfile,
);

router.get(
  '/profile/:activeId/follows/:profileId',
  verifyAuthentication,
  profileController.getFollowStatus,
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

router.get(
  '/profiles/:profileId/bookmarks',
  verifyAuthentication,
  profileController.getBookmarks,
);

router.post(
  '/profiles/:profileId/bookmarks',
  verifyAuthentication,
  profileController.createBookmark,
);

router.delete(
  '/profiles/:profileId/bookmarks/:postId',
  verifyAuthentication,
  profileController.deleteBookmark,
);

router.delete(
  '/profiles/:profileId/bookmarks',
  verifyAuthentication,
  profileController.deleteAllBookmarks,
);

router.get(
  '/profiles/:profileId/notifications',
  verifyAuthentication,
  profileController.getNotifications,
);

export default router;
