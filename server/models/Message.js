const mongoose  = require('mongoose');


const messageSchema = new mongoose.Schema({
    sender: {type: mongoose.Schema.Types.ObjectId , ref : 'User', required: true},
    recipient: {type: mongoose.Schema.Types.ObjectId, ref: 'User' , required : true},
    group: {type : mongoose.Schema.Types.ObjectId, ref : 'Group'},
    content: {type: String, required: true},
    timestamp : {type : Date , default: Date.now}
});

const Message = mongoose.model('Message' , messageSchema);

module.exports = Message;
