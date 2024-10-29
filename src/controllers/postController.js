import notificationServices from '../services/notificationServices.js';
import postServices from '../services/postServices.js';

const postController = {
  getFollowedPosts: async (req, res) => {
    try {
      const page = Number(req.query.page);
      const { posts, totalPosts, hasMore } =
        await postServices.getFollowedPosts(req.params.id, page, 3);
      if (!posts) {
        return res.status(400).json({ message: 'No posts found' });
      }
      res.status(200).json({
        posts,
        totalPosts,
        hasMore,
        message: 'Successfully fetched feed posts',
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deletePost: async (req, res) => {
    try {
      await postServices.deletePost(req.params.id);
      res.status(200).json({ message: 'Successfully deleted post' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  getExplorePosts: async (req, res) => {
    try {
      const { posts, totalPosts, hasMore } = await postServices.getExplorePosts(
        req.query.activeId,
        req.query.page,
        9,
      );
      if (!posts) {
        return res.status(400).json({ message: 'No explore posts found' });
      }
      res.status(200).json({
        posts,
        totalPosts,
        hasMore,
        message: 'Successfully fetched explore posts',
      });
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
};

export default postController;
