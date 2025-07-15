#if !macro
//Discord API
#if DISCORD_ALLOWED
import backend.Discord;
#end

//Psych
#if LUA_ALLOWED
import llua.*;
import llua.Lua;
#end

#if ACHIEVEMENTS_ALLOWED
import backend.Achievements;
#end

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

import backend.Paths;
import backend.Controls;
import backend.CoolUtil;
import backend.MusicBeatState;
import backend.MusicBeatSubstate;
import backend.CustomFadeTransition;
import backend.ClientPrefs;
import backend.Conductor;
import backend.BaseStage;
import backend.Difficulty;
import backend.Mods;
import backend.Language;

//customstuff
import backend.SpriteFromSheet;
import backend.FunkinSprite;
import backend.CitrusUtil;

import backend.ui.*; //Psych-UI

import objects.Alphabet;
import objects.BGSprite;

import states.aechos.TitleState;
import states.LoadingState;
import states.PlayState;

#if flxanimate
import flxanimate.*;
import flxanimate.PsychFlxAnimate as FlxAnimate;
#end

#if VIDEOS_ALLOWED
import hxvlc.flixel.*;
import hxvlc.openfl.*;
#end

//Flixel
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.shapes.FlxShapeDonut;

//Stupid
import backend.CoolUtil.addShaderToCamera as ApplyShaderToCamera;
import backend.CoolUtil.removeShaderFromCamera as RemoveShaderFromCamera;
import backend.CoolUtil.clearShadersFromCamera as ClearShadersFromCamera;

using backend.FlxObjectTools;
using StringTools;
#end
