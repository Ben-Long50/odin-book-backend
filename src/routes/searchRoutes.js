import express from 'express';
import searchController from '../controllers/searchController.js';

const router = express.Router();

router.get('/search/:query', searchController.searchProfiles);

router.post('/search/:id', searchController.createSearch);

router.delete('/search/:id', searchController.deleteSearch);

router.delete('/search', searchController.deleteAllSearches);

export default router;
