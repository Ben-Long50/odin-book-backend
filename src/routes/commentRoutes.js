import express from 'express';
import commentController from '../controllers/commentController.js';
import { verifyAuthentication } from '../passport/passport.js';

const router = express.Router();

router.get('/post/:postId/comments', commentController.getComments);

router.delete(
  '/comment/:commentId',
  verifyAuthentication,
  commentController.deleteComment,
);

router.post(
  '/comments/:id/like',
  verifyAuthentication,
  commentController.likeComment,
);

router.delete(
  '/comments/:id/like',
  verifyAuthentication,
  commentController.unlikeComment,
);

export default router;
