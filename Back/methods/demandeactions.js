var User = require('../models/user')
var Demandesmodel = require('../models/demande')
var config = require('../config/dbconfig');
const { update } = require('../models/user');

var functions = {

    //Add Demande
 addDem: function (req, res) {
       
      const ev = new Demandesmodel({
          type: req.body.type,
          apport: req.body.apport,
          montant: req.body.montant,
          resultat: req.body.resultat,
          duree: req.body.duree,
          period: req.body.period,
          date: req.body.date
      });
              
          ev.save(function (err, ev) {
            if (err) {
                res.json({success: false, msg: 'Failed to save'})
            }
            else {
                res.json({success: true, msg: 'Successfully saved'})
                console.log("Demande ++");
            }
        })
    },
    
    //View All Demandes
    viewAll : function (req,res) {
      //console.log("Get all Demandes");
      Demandesmodel.find({}).exec(function (err, ev) {
        if (err) {
          console.log("Error View All Demandes ");
        } else {
          res.json(ev);
        }
      });
    },
    
    //Update Demande
    updateDem: function (req, res) {
        
        Demandesmodel.findByIdAndUpdate(req.params.id,
          {
            $set: {
                type: req.body.type,
                apport: req.body.apport,
                montant: req.body.montant,
                resultat: req.body.resultat,
                duree: req.body.duree,
                period: req.body.period,
                date: req.body.date
            },
          },
      
          function (err, updated) {
            if (err) {
              res.json({success: false, msg: 'Failed to Update'})
            } else {
              res.json({success: true, msg: 'Successfully Updated'})
              console.log("Demande updated ++");
            }
          }
        );
      },
    
    
    //Delete Demande
      annulerDem: function (req, res) {
    
        console.log("Demande deleted -- ");
        Demandesmodel.findOneAndDelete(req.params.id, function (err, deleted) {
          if (err) {
            res.json({success: false, msg: 'Failed to Delete'})
          } else {
            res.json({success: true, msg: 'Successfully Deleted'})
          }
        });
    
      }
}

module.exports = functions