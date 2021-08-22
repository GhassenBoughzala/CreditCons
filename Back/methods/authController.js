const {Router} = require('express')
const router = Router()

const User = require('../models/user')
const verifyToken = require('./verifyToken')
const jwt = require ('jsonwebtoken')
const jwtt = require('jwt-simple')
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
    User.findOne({email: req.body.email}, 
        function (err, user) {
            if (err) throw err
            if (!user) {
                console.log("User not found")
                res.status(403).send({
                        success: false,
                        msg: 'Authentication Failed, User not found'})
            } 
            else {
                user.comparePassword(req.body.password, function (err, isMatch) {
                    if (isMatch && !err) {
                        var token = jwtt.encode(user, config.secret)
                        res.json({success: true, token: token})
                    }
                    else {
                        return res.status(403).send({success: false, msg: 'Authentication failed, wrong password'})
                    }
                })
            }
    }
    )

    /*    try{
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
    */  
    },

logout: function(req,res){
        console.log("USER OUT");
        res.status(200).send({ auth: false, token:null, msg: 'Logout'});
    }

}
module.exports = fn;