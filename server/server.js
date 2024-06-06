const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config();

const app = express();

app.use(express.json());

app.use('/auth' , require('./routes/authRoutes'));
app.use('/dm' , require('./routes/dmRoutes'));
app.use('/group', require('./routes/groupChatRoutes'));

mongoose.connect(process.env.MONGODB_URI).then(() => {
    console.log('Connected to MongoDB');
    const PORT = process.env.PORT || 3000;
    app.listen(PORT , () => {
        console.log(`Server is running on port ${PORT}`);
    });
})
.catch(error => console.error('MongoDB connection error:', error));