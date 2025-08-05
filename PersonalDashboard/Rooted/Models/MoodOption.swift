//
//  MoodOption.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/11/25.
//

import Foundation

enum MoodOption: String, CaseIterable, Codable {
	case scrollToPick = "Scroll here!"
	case happy = "Happy"
	case sad = "Sad"
	case anxious = "Anxious"
	case excited = "Excited"
	case tired = "Tired"
	case motivated = "Motivated"
	case stressed = "Stressed"
	case relaxed = "Relaxed" 
	case hopeful = "Hopeful"
	case frustrated = "Frustrated"
	case calm = "Calm"
	case grateful = "Grateful"
	case overwhelmed = "Overwhelmed"
	case focused = "Focused"
	case joyful = "Joyful"
	case melancholy = "Melancholy"
	case creative = "Creative"
	case lonely = "Lonely"
	case confident = "Confident"
	case scattered = "Scattered"
	case peaceful = "Peaceful"
	case inspired = "Inspired" 
	case burntOut = "Burnt Out"
	case loved = "Loved"
	case content = "Content"
	case energetic = "Energetic"
	case reflective = "Reflective"
	case curious = "Curious"
	case nostalgic = "Nostalgic"
	case playful = "Playful"
}


// At least 4 each. Can be more later
// Can have overlap
extension MoodOption {
	var associatedFlowers: [FlowerType] {
		switch self {
		case .happy:
			return [.sunflower, .daisy, .tulip, .pansy, .daffodil]
		case .sad:
			return [.bluebell, .snowdrop, .lilyOfTheValley, .forgetMeNot]
		case .anxious:
			return [.jasmine, .anemone, .iris, .moonflower]
		case .excited:
			return [.zinnia, .marigold, .honeysuckle, .chrysanthemum]
		case .tired:
			return [.chamomile, .lavender, .bluebell, .nightshade]
		case .motivated:
			return [.clover, .dandelion, .tulip, .cherryBlossom]
		case .stressed:
			return [.hellebore, .cactus, .ghostOrchid]
		case .relaxed:
			return [.gardenia, .wisteria, .orchid, .buttercup]
		case .hopeful:
			return [.daffodil, .camellia, .hydrangea, .honeysuckle]
		case .frustrated:
			return [.thistle, .anemone, .fireLily, .blackTulip]
		case .calm:
			return [.jasmine, .hydrangea, .lilyOfTheValley, .lily]
		case .grateful:
			return [.peony, .sweetPea, .yarrow, .carnation]
		case .overwhelmed:
			return [.moonflower, .cactus, .desertRose, .cornflower]
		case .focused:
			return [.iris, .edelweiss, .clover, .gardenia]
		case .joyful:
			return [.cosmos, .pansy, .cherryBlossom, .hydrangea]
		case .melancholy:
			return [.lilyOfTheValley, .bleedingHeart, .blackTulip, .chrysanthemum]
		case .creative:
			return [.orchid, .pansy, .poppy, .lily]
		case .lonely:
			return [.forgetMeNot, .bluebell, .lilyOfTheValley, .bleedingHeart]
		case .confident:
			return [.rose, .protea, .calendula, .chrysanthemum]
		case .scattered:
			return [.dandelion, .clover, .thistle, .yarrow]
		case .peaceful:
			return [.chamomile, .snowdrop, .lotus, .wisteria]
		case .inspired:
			return [.sunflower, .calendula, .camellia, .carnation]
		case .burntOut:
			return [.cactus, .fireLily, .blackTulip, .iris]
		case .loved:
			return [.rose, .lily, .chrysanthemum, .cherryBlossom, .redCap]
		case .content:
			return [.tulip, .poppy, .lily, .anemone]
		case .energetic:
			return [.zinnia, .marigold, .pansy, .honeysuckle]
		case .reflective:
			return [.ghostOrchid, .iris, .cosmos, .snowdrop]
		case .curious:
			return [.honeysuckle, .buttercup, .orchid, .jasmine]
		case .nostalgic:
			return [.forgetMeNot, .camellia, .chamomile, .edelweiss]
		case .playful:
			return [.pansy, .cosmos, .buttercup, .daffodil]
		case .scrollToPick:
			return [.cherryBlossom]
		}
	}
}
