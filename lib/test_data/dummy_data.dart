import 'package:flutter/material.dart';
import '../models/locations.dart';

const DUMMY_LOCATIONS = [
  Locations(
    id: 'l1',
    title: 'Saraswati Idol',
    coOrdinates: {
      'latitude': 74.60173842596902,
      'longitude': 16.84395552735782
    },
    imageUrl:
        'https://imgs.search.brave.com/AWeyv7Nc5e8o4jFLXrWqAm0tUuCKdzZ8GNESmWJn_JU/rs:fit:1200:1200:1/g:ce/aHR0cDovLzEuYnAu/YmxvZ3Nwb3QuY29t/Ly1VdXpEdlJVWGpo/OC9UZHhpLTB1U1Zr/SS9BQUFBQUFBQUFV/VS9qUmZwa3JhX21t/Yy9zMTYwMC9XYWxj/aGFuZCtjb2xsZWdl/K29mK2VuZ2luZWVy/aW5nJTI1MkMrc2Fu/Z2xpK21lbW9yaWVz/X0Nvb2wrQU1QU1Mu/Li4uanBn',
    description:
        'The Idol of the goddess Saraswati who is considered the symbol of Knowledge. This Statue is located in the middle of a small garden and in front of the Ajit Gulabchand Library of the college',
  ),
  Locations(
    id: 'l2',
    title: 'Ajit Gulabchand Library',
    coOrdinates: {'latitude': 74.6018126727777, 'longitude': 16.84423533154822},
    imageUrl:
        'https://imgs.search.brave.com/AFz_uFTnNsXg4v1vSDBwOny4DJLF6CP6Z3fyaV2o1Ws/rs:fit:700:525:1/g:ce/aHR0cDovL3Bob3Rv/cy53aWtpbWFwaWEu/b3JnL3AvMDAvMDUv/NzgvMzAvNDJfYmln/LmpwZw',
    description:
        'The famous library of the wanchand college of Engineering and is also said to have evry book you will need throughout your course in this college',
  ),
];
