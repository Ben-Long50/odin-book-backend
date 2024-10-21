import express from 'express';
import postController from '../controllers/postController.js';
import { verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.get('/posts/:id', verifyAuthentication, postController.getFollowedPosts);

router.delete('/posts/:id', verifyAuthentication, postController.deletePost);

router.get('/explore/posts', postController.getExplorePosts);

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

export default router;
