import notificationServices from '../services/notificationServices.js';
import postServices from '../services/postServices.js';

const postController = {
  getFollowedPosts: async (req, res) => {
    try {
      const posts = await postServices.getFollowedPosts(req.params.id);
      if (!posts) {
        return res.status(400).json({ message: 'No posts found' });
      }
      res.status(200).json(posts);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  getExplorePosts: async (req, res) => {
    try {
      const posts = await postServices.getExplorePosts(req.query.activeId);
      if (!posts) {
        return res.status(400).json({ message: 'No explore posts found' });
      }

      res.status(200).json({ posts });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  likePost: async (req, res) => {
    try {
      const postLike = await postServices.likePost(
        req.params.id,
        req.body.activeId,
      );

      await notificationServices.createPostLikeNotification(
        req.body.activeId,
        postLike.post.profileId,
        postLike.postLike.id,
      );
      res.status(200).json({ message: 'Successfully liked post' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  unlikePost: async (req, res) => {
    try {
      await postServices.unlikePost(req.params.id, req.body.activeId);
      res.status(200).json({ message: 'Successfully unliked post' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  createComment: async (req, res) => {
    try {
      const comment = await postServices.createComment(
        req.params.id,
        req.body.activeId,
        req.body.comment,
      );

      await notificationServices.createCommentNotification(
        req.body.profileId,
        req.body.activeId,
        comment.id,
      );
      res.status(200).json({ message: 'Successfully created comment' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteComment: async (req, res) => {
    try {
      await postServices.deleteComment(req.body.commentId);
      res.status(200).json({ message: 'Successfully deleted comment' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

export default postController;
