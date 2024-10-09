import searchServices from '../services/searchServices.js';

const searchController = {
  searchProfiles: async (req, res) => {
    try {
      const profiles = await searchServices.searchProfiles(req.params.query);
      if (!profiles) {
        return res.status(400).json({ message: 'No profiles found' });
      }
      res.json({
        profiles,
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

export default searchController;
