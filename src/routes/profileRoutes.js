import express from 'express';
import profileController from '../controllers/profileController.js';
import { verifyAuthentication } from '../passport/passport.js';
import searchController from '../controllers/searchController.js';

const router = express.Router();

router.get('/profiles', verifyAuthentication, profileController.getProfiles);

router.get(
  '/profiles/active',
  verifyAuthentication,
  profileController.getActiveProfile,
);

router.get('/profiles/:id', profileController.getProfile);

router.get('/profiles/:id/posts', profileController.getPosts);

router.get(
  '/profiles/:profileId/bookmarks',
  verifyAuthentication,
  profileController.getBookmarks,
);

router.get(
  '/profiles/:profileId/notifications',
  verifyAuthentication,
  profileController.getNotifications,
);

router.get('/profiles/:id/searches', searchController.getSearches);

router.get(
  '/profiles/:activeId/follows/:profileId',
  verifyAuthentication,
  profileController.getFollowStatus,
);

router.post(
  '/profiles',
  verifyAuthentication,
  profileController.createOrUpdateProfile,
);

router.post(
  '/profiles/:id/follows',
  verifyAuthentication,
  profileController.followProfile,
);

router.post(
  '/profiles/:profileId/bookmarks',
  verifyAuthentication,
  profileController.createBookmark,
);

router.put(
  '/profiles/:profileId',
  verifyAuthentication,
  profileController.setActiveProfile,
);

router.delete(
  '/profiles/:id',
  verifyAuthentication,
  profileController.deleteProfile,
);

router.delete(
  '/profiles/:id/follows',
  verifyAuthentication,
  profileController.unfollowProfile,
);

router.delete(
  '/profiles/:profileId/bookmarks/:postId',
  verifyAuthentication,
  profileController.deleteBookmark,
);

export default router;
