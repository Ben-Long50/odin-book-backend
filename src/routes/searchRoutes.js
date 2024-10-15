import express from 'express';
import searchController from '../controllers/searchController.js';

const router = express.Router();

router.get('/search/:query', searchController.searchProfiles);

router.get('/searches/:id', searchController.getSearches);

router.post('/search/:id', searchController.createSearch);

router.put('/search/:id', searchController.deleteSearch);

router.delete('/searches/:id', searchController.deleteAllSearches);

export default router;
