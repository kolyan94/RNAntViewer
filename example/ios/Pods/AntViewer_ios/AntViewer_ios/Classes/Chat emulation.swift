//
//  Chat emulation.swift
//  controllers fot kolya
//
//  Created by Maryan Luchko on 12/20/18.
//  Copyright © 2018 Maryan Luchko. All rights reserved.
//

import Foundation

class ChatEmulation {
  
static private let video_1: [Message] = [ Message(timestamp: 2, nickname: "LondonLion", text: "These lads literally get paid to play football everyday…"),
                           Message(timestamp: 3, nickname: "Jaybob", text: "Where is this? Where’s the training ground?"),
                           Message(timestamp: 7, nickname: "ChelskiChris", text: "This is pretty cool, why hasn’t this been possible forever?"),
                           Message(timestamp: 8, nickname: "TheGunnar", text: "The Spurs lads look like a bunch of fun 🤔"),
                           Message(timestamp: 9, nickname: "LondonLion", text: "St. George’s Park I think Jaybob"),
                           Message(timestamp: 16, nickname: "Jaybob", text: "Not far from me!"),
                           Message(timestamp: 18, nickname: "SteveTheSpur", text: "haha"),
                           Message(timestamp: 22, nickname: "TheGunnar", text: "A spurs fan would think that’s funny!"),
                           Message(timestamp: 24, nickname: "WelcometoManc", text: "Look like pretty good mates?!??! Maybe…."),
                           Message(timestamp: 26, nickname: "ChelskiChris", text: "At least they’re taking it seriously…"),
                           Message(timestamp: 27, nickname: "SteveTheSpur", text: "No chance Welcome to Manc"),
                           Message(timestamp: 28, nickname: "WelcometoManc", text: "That’s how I would behave. Enjoy right!")
]

static private let video_2: [Message] = [ Message(timestamp: 1, nickname: "CityBlue", text: "I actually love these boys, seem like normal lads!"),
                           Message(timestamp: 2, nickname: "ChelskiChris", text: "Kyle Walker or Alexander-Arnold?"),
                           Message(timestamp: 3, nickname: "RedDevil", text: "Yeah they do seem alright. Hurts to say."),
                           Message(timestamp: 5, nickname: "TheGunnar", text: "Hmmmmm Can I vote for Lee Dixon?"),
                           Message(timestamp: 7, nickname: "LondonLion", text: "AA is a much smarter footballer"),
                           Message(timestamp: 10, nickname: "JoeyJim", text: "Not sure now, but in a few years it will be AA"),
                           Message(timestamp: 11, nickname: "SteveTheSpur", text: "I just wish Robertson was English."),
                           Message(timestamp: 13, nickname: "TheGunnar", text: "Roommates is the best show on here."),
                           Message(timestamp: 14, nickname: "BrexitBaby", text: "Nah Kyle is much more reliable at the back!"),
                           Message(timestamp: 17, nickname: "SteveTheSpur", text: "Not sure about that JoeyJim. Even as a spurts fan."),
                           Message(timestamp: 18, nickname: "ChelskiChris", text: "hahahhahaha Hilarious")
]

static private let video_3: [Message] = [ Message(timestamp: 1, nickname: "SuperLion", text: "They’re struggling"),
                           Message(timestamp: 3, nickname: "StephHoughtonNo1", text: "It’s gonna be tough from here."),
                           Message(timestamp: 4, nickname: "SteveTheSpur", text: "Credit where it’s due, the Swede’s are pretty good."),
                           Message(timestamp: 5, nickname: "GottaBelieve", text: "Come on England!!!!!"),
                           Message(timestamp: 8, nickname: "StephHoughtonNo1", text: "Agreed SteveTheSpur, well organised."),
                           Message(timestamp: 9, nickname: "StephHoughtonNo1", text: "😔"),
                           Message(timestamp: 13, nickname: "SuperLion", text: "GottaBelieve, Gotta Believe!"),
                           Message(timestamp: 18, nickname: "TheGunnar", text: " StephHoughtonNo1, have you seen Steph on Roommates?"),
                           Message(timestamp: 22, nickname: "TheGunnar", text: "Roommates is the best show on here, I say that all the time"),
                           Message(timestamp: 24, nickname: "BrexitBaby", text: "Loads of time left to play."),
                           Message(timestamp: 25, nickname: "Jaybob", text: "I fancy the Swedes to do well in the next few tournaments."),
                           Message(timestamp: 26, nickname: "LondonLion", text: "Good finish")
]

static private let video_4: [Message] = [ Message(timestamp: 2, nickname: "RedDevil", text: "These boys are pretty good!"),
                           Message(timestamp: 3, nickname: "StephHoughtonNo1", text: "They’re not holding back!!!!"),
                           Message(timestamp: 4, nickname: "UptheReds", text: "Liverpool have got so many good young players coming through"),
                           Message(timestamp: 5, nickname: "LondonLion", text: "Skillllzzzzzz"),
                           Message(timestamp: 8, nickname: "Jaybob", text: "This is better than watching an actual game"),
                           Message(timestamp: 9, nickname: "StephHoughtonNo1", text: "😔"),
                           Message(timestamp: 13, nickname: "TheGunnar", text: "Agreed, I don’t know where the Scousers are getting them from."),
                           Message(timestamp: 14, nickname: "BrexitBaby", text: "I like this, full on training, no holding back"),
                           Message(timestamp: 16, nickname: "RedDevil", text: "When is the next U21 comp?"),
                           Message(timestamp: 18, nickname: "LondonLion", text: "This summer")
]

static private let video_5: [Message] = [ Message(timestamp: 1, nickname: "CityBlue", text: "OH MY GOD"),
                           Message(timestamp: 3, nickname: "ChelskiChris", text: "Is this going to happen?"),
                           Message(timestamp: 4, nickname: "RedDevil", text: "COME ON ENGLAND!!!!!"),
                           Message(timestamp: 8, nickname: "TheGunnar", text: "This is so England"),
                           Message(timestamp: 9, nickname: "LondonLion", text: " Positivity, positivity, positivity."),
                           Message(timestamp: 16, nickname: "JoeyJim", text: "Eric Dier 🙈 🙈 🙈"),
                           Message(timestamp: 18, nickname: "SteveTheSpur", text: "It’s coming home!!!!!"),
                           Message(timestamp: 22, nickname: "TheGunnar", text: "FOOTBALL IS COMING HOME"),
                           Message(timestamp: 24, nickname: "BrexitBaby", text: " THIS IS IT!!!!"),
                           Message(timestamp: 25, nickname: "SteveTheSpur", text: "OH MY GOD AGAIN"),
                           Message(timestamp: 27, nickname: "ChelskiChris", text: "I need a nap.")
]

static private let video_6: [Message] = [ Message(timestamp: 1, nickname: "UptheReds", text: "JLing, JLing, JLing, JLing, JLing, JLing, JLing"),
                           Message(timestamp: 3, nickname: "OOOHAAAAH….", text: "Love him and his mum at the world cup"),
                           Message(timestamp: 7, nickname: "RedDevil", text: "He knows who he’s gotta get… I think they’re mates too."),
                           Message(timestamp: 8, nickname: "BigOleGunnar", text: "It has all been spurs"),
                           Message(timestamp: 9, nickname: "LondonLion", text: "AA is a much smarter footballer"),
                           Message(timestamp: 13, nickname: "BrexitBaby", text: "Surely the reporters can’t be happy!"),
                           Message(timestamp: 18, nickname: "SteveTheSpur", text: "England is all Spurs BigOleGunnar 😎"),
                           Message(timestamp: 22, nickname: "TheGunnar", text: "More roommates!!!!!"),
                           Message(timestamp: 24, nickname: "BrexitBaby", text: "Looks pretty happy to be rescued."),
                           Message(timestamp: 26, nickname: "SteveTheSpur", text: "Not sure about that JoeyJim. Even as a spurts fan."),
                           Message(timestamp: 30, nickname: "ChelskiChris", text: "Still not sure Jesse will be at United longterm. Chelsea will have him!"),
                           Message(timestamp: 34, nickname: "SteveTheSpur", text: "This is on YouTube too?")
]

static private let video_7: [Message] = [ Message(timestamp: 1, nickname: "BringBackShearer", text: "How do I get this job?"),
                           Message(timestamp: 3, nickname: "ChelskiChris", text: "Rach Stringer is pretty cool!"),
                           Message(timestamp: 4, nickname: "GottaBelieve", text: "Do you find yourself watching this instead of the footy?"),
                           Message(timestamp: 5, nickname: "TheGunnar", text: "I remember when Arsenal used to have a few England players 😴"),
                           Message(timestamp: 8, nickname: "StephHoughtonNo1", text: "This is me, I’m gonna win this.."),
                           Message(timestamp: 9, nickname: "JoeyJim", text: "Really worried about fatigue here"),
                           Message(timestamp: 14, nickname: "SuperLion", text: "Where’s Gotta Believe when you need them?!"),
                           Message(timestamp: 21, nickname: "TheGunnar", text: "Have I mentioned Roommates?"),
                           Message(timestamp: 24, nickname: "TheGunnar", text: "Roommates is the best show on here, I say that all the time"),
                           Message(timestamp: 27, nickname: "SteveTheSpur", text: "I know this, I think I do know, I think"),
                           Message(timestamp: 32, nickname: "Jaybob", text: "They watch football for a living!!??!?!?!"),
                           Message(timestamp: 35, nickname: "RedDevil", text: "I watched that show, can’t remember")
]

public static let chatEmulationVideoArray = [video_1, video_2, video_3, video_4, video_5, video_6, video_7]

}
