import commentServices from '../services/commentServices.js';

const commentController = {
  likeComment: async (req, res) => {
    try {
      await commentServices.likeComment(req.params.id, req.body.activeId);
      res.status(200).json({ message: 'Successfully liked comment' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  unlikeComment: async (req, res) => {
    try {
      await commentServices.unlikeComment(req.params.id, req.body.activeId);
      res.status(200).json({ message: 'Successfully unliked comment' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

export default commentController;
