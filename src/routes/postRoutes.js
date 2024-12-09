import express from 'express';
import postController from '../controllers/postController.js';
import { verifyAuthentication } from '../passport/passport.js';
import profileController from '../controllers/profileController.js';
import commentController from '../controllers/commentController.js';

const router = express.Router();

router.get('/posts/explore', postController.getExplorePosts);

router.get('/posts/:id', verifyAuthentication, postController.getFollowedPosts);

router.get('/posts/:postId/comments', commentController.getComments);

router.post('/posts', verifyAuthentication, profileController.createPost);

router.post('/posts/:id/likes', verifyAuthentication, postController.likePost);

router.post(
  '/posts/:id/comments',
  verifyAuthentication,
  postController.createComment,
);

router.delete('/posts/:id', verifyAuthentication, postController.deletePost);

router.delete(
  '/posts/:id/likes',
  verifyAuthentication,
  postController.unlikePost,
);

export default router;
