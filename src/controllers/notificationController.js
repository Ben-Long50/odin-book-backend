import notificationServices from '../services/notificationServices.js';

const notificationController = {
  deleteNotification: async (req, res) => {
    try {
      await notificationServices.deleteNotification(req.params.id);

      res.status(200).json({ message: 'Successfully deleted Notification' });
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
