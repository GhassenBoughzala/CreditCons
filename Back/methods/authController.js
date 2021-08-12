const {Router} = require('express')
const router = Router()

const User = require('../models/user')
const verifyToken = require('./verifyToken')
const jwt = require ('jsonwebtoken')
const config = require ('../config/dbconfig')



var fn= {


signup: async(req,res) => {
        try{
            const {name,lastname,iban,email,password} = req.body;

            const newuser = new User({
                name,
                lastname,
                iban,
                email,
                password
            });
            
            await newuser.save();
            const token = jwt.sign({id: User.id}, config.secret);
            res.status(200).json({auth: true, token});

        }catch(err) {
            console.log(err)
            res.status(500).send('Problemo in SignUp')    
        }
    },

signin: async(req,res) => {
        try{
            const user = await User.findOne({email: req.body.email})
            if(!user){
                return res.status(404).send("The Email doesn't exist")
            }
            const validPass = await (req.body.password, User.password)
            if(!user){
                return res.status(401).send({auth: false, token: null})
            }

            const token = jwt.sign({id: User._id}, config.secret);
            res.status(200).json({auth: true, token});

        }catch (err){
            console.log(err)
            res.status(500).send('Problemo in SignIn') 
        }
    },

logout: function(req,res){
        res.status(200).send({ auth: false, token:null});
    }

}
module.exports = fn;