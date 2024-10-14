import express from 'express';
import postController from '../controllers/postController.js';
import { verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.get('/posts/:id', verifyAuthentication, postController.getFollowedPosts);

router.get('/posts/:id/like', postController.getPostLikes);

router.post('/posts/:id/like', verifyAuthentication, postController.likePost);

router.delete(
  '/posts/:id/like',
  verifyAuthentication,
  postController.unlikePost,
);

export default router;
