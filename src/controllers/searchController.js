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

  getSearches: async (req, res) => {
    try {
      const searches = await searchServices.getSearches(req.params.id);
      res.status(200).json({
        searches,
        message: 'Successfully fetched search history',
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  createSearch: async (req, res) => {
    try {
      const search = await searchServices.createSearch(
        req.params.id,
        req.body.activeId,
      );
      res.status(200).json({
        search,
        message: 'Successfully created search entry',
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteSearch: async (req, res) => {
    try {
      await searchServices.deleteSearch(req.params.id, req.body.activeId);
      res.status(200).json({
        message: 'Successfully deleted search entry',
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deleteAllSearches: async (req, res) => {
    try {
      await searchServices.deleteAllSearches(req.params.id);
      res.status(200).json({
        message: 'Successfully deleted search history',
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

export default searchController;
