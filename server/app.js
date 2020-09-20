const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const mongoose = require('mongoose');
const authRoutes = require('./routes/auth');
const userProfile = require('./routes/profile');
const keys = require("./config/keys")


//connect DB
mongoose.connect(keys.mongoURL,{
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false

})
    .then(()=>{
        console.log('connect db accept');
    })
    .catch(error =>{
        console.log(error);
    })



app.use(morgan('dev'))
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json());
app.use(cors());

//routes
app.use('/api/auth', authRoutes)
app.use('/api/profile',userProfile)


module.exports = app;