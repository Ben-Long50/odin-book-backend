import express from 'express';
import postController from '../controllers/postController.js';
import { verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.get('/posts/:id', verifyAuthentication, postController.getFollowedPosts);

router.post('/posts/:id/like', verifyAuthentication, postController.likePost);

router.delete(
  '/posts/:id/like',
  verifyAuthentication,
  postController.unlikePost,
);

router.post(
  '/posts/:id/comment',
  verifyAuthentication,
  postController.createComment,
);

router.delete(
  '/posts/:id/comment',
  verifyAuthentication,
  postController.deleteComment,
);

export default router;
