import notificationServices from '../services/notificationServices.js';

const notificationController = {
  createShareNotification: async (req, res) => {
    try {
      await notificationServices.createShareNotification(
        req.body.activeId,
        req.body.postId,
        req.body.shareList,
      );

      res
        .status(200)
        .json({ message: 'Successfully created share notifications' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteNotification: async (req, res) => {
    try {
      await notificationServices.deleteNotification(req.params.id);

      res.status(200).json({ message: 'Successfully deleted notification' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteAllNotifications: async (req, res) => {
    try {
      await notificationServices.deleteAllNotifications(req.body.activeId);
      res
        .status(200)
        .json({ message: 'Successfully deleted all notifications' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

export default notificationController;
