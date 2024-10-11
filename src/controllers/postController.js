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
};

export default postController;
