#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'telebot'
require 'pp'
require 'open-uri'
require 'json'
require 'nokogiri'

bot = Telebot::Bot.new("210674266:AAFAa_jWq19fzzF9Mh8gSuf25rfyO0FsN2w")

def psb
  today = Date.today.strftime("%d/%m/%Y")
  encode_url = URI.encode("http://mydashboard.telkom.co.id/ms2/detil_progres_useetv2_.php?sub_chanel=%&chanel=%&p_kawasan=DIVRE_6&witel=KALTENG&indihome=&kode=1&c_witel=43&p_cseg=%&p_etat=5&start_date=#{today}&end_date=#{today}&indihome=&migrasi=&starclick=&plblcl=&inden=&status_order=PS")
  #psb = Nokogiri::HTML(open(encode_url)).css("table tr[bgcolor='']")
  ps = Nokogiri::HTML(open(encode_url)).css("table tr[bgcolor='']")

  plk = 0
  kkn = 0
  kkp = 0
  pps = 0
  pym = 0

  kmi = 0
  sua = 0
  pbu = 0

  sai = 0
  kpb = 0

  amp = 0
  prc = 0
  bnt = 0
  tml = 0
  mtw = 0

  ps.each do |stox|

    if stox.css("td")[11].text == 'PLK'
      plk = (plk + 1)
    elsif stox.css("td")[11].text == 'KKN'
      kkn = (kkn + 1)
    elsif stox.css("td")[11].text == 'KKP'
      kkp = (kkp + 1)
    elsif stox.css("td")[11].text == 'PPS'
      pps = (pps + 1)
    elsif stox.css("td")[11].text == 'PYM'
      pym = (pym + 1)
    elsif stox.css("td")[11].text == 'KMI'
      kmi = (kmi + 1)
    elsif stox.css("td")[11].text == 'SUA'
      sua = (sua + 1)
    elsif stox.css("td")[11].text == 'PBU'
      pbu = (pbu + 1)
    elsif stox.css("td")[11].text == 'SAI'
      sai = (sai + 1)
    elsif stox.css("td")[11].text == 'KPB'
      kpb = (kpb + 1)
    elsif stox.css("td")[11].text == 'AMP'
      amp = (amp + 1)
    elsif stox.css("td")[11].text == 'PRC'
      prc = (prc + 1)
    elsif stox.css("td")[11].text == 'BNT'
      bnt = (bnt + 1)
    elsif stox.css("td")[11].text == 'TML'
      tml = (tml + 1)
    elsif stox.css("td")[11].text == 'MTW'
      mtw = (mtw + 1) 
    end

  end
  
  sto = Hash[
              "PLK" => plk,
              "KKN" => kkn,
              "KKP" => kkp,
              "PPS" => pps,
              "PYM" => pym,

              "PBU" => pbu, 
              "SUA" => sua, 
              "KMI" => kmi,

              "SAI" => sai, 
              "KPB" => kpb,

              "MTW" => mtw,
              "AMP" => amp,
              "PRC" => prc,
              "BNT" => bnt,
              "TML" => tml,
            ]

  msg = "PSB HI : #{ps.count} \n"\
        "\n"\
        "PLK : #{sto['PLK']}\n"\
        "KKN : #{sto['KKN']}\n"\
        "KKP : #{sto['KKP']}\n"\
        "PPS : #{sto['PPS']}\n"\
        "PYM : #{sto['PYM']}\n"\
        "\n"\
        "PBU : #{sto['PBU']}\n"\
        "SUA : #{sto['SUA']}\n"\
        "KMI : #{sto['KMI']}\n"\
        "\n"\
        "SAI : #{sto['SAI']}\n"\
        "KPB : #{sto['KPB']}\n"\
        "\n"\
        "MTW : #{sto['MTW']}\n"\
        "AMP : #{sto['AMP']}\n"\
        "PRC : #{sto['PRC']}\n"\
        "BNT : #{sto['BNT']}\n"\
        "TML : #{sto['TML']}\n"\

  #puts "PLK : #{sto['PLK']}"

  return msg
end

bot.run do |client, message|
  markup = Telebot::ReplyKeyboardMarkup.new(
    keyboard: [
      ["PSB Kalteng"],
      # [ "get_me", "send_message", "forward_message" ],
      # [ "send_photo", "send_audio", "send_document" ],
      # [ "send_sticker", "send_video", "send_location"],
      # [ "send_chat_action", "get_user_profile_photos"]
    ]
  )

  case message.text
  when /start/
    msg = "Hi! I am a demo bot that demonstrates abilities of telebot library: https://github.com/greyblake/telebot \n" \
          "You can check my source code here: https://github.com/greyblake/telebot/blob/master/examples/demo.rb \n" \
          "Please pick any command to try me out ;) \n"
    client.send_message(chat_id: message.chat.id, text: msg, reply_markup: markup)

  when /PSB Kalteng/
  msg = psb
    client.send_message(chat_id: message.chat.id, text: msg)

  # when /get_me/
  #   user = client.get_me
  #   msg = "ID: #{user.id}\n"
  #   msg << "First name: #{user.first_name}\n"
  #   msg << "Last name: #{user.last_name}\n"
  #   msg << "Username: #{user.username}"
  #   client.send_message(chat_id: message.chat.id, text: msg)

  # when /send_message/
  #   client.send_message(chat_id: message.chat.id, text: "Hello, man! What's going on?")

  # when /forward_message/
  #   client.forward_message(chat_id: message.chat.id, from_chat_id: message.chat.id, message_id: message.message_id)

  # when /send_photo/
  #   file = Telebot::InputFile.new(fixture("bender_pic.jpg"), 'image/jpeg')
  #   client.send_photo(chat_id: message.chat.id, photo: file)

  # when /send_audio/
  #   client.send_message(chat_id: message.chat.id, text: "Let me say 'Hi' in Esperanto.")
  #   file = Telebot::InputFile.new(fixture("saluton_amiko.ogg"))
  #   client.send_audio(chat_id: message.chat.id, audio: file)

  # when /send_document/
  #   file = Telebot::InputFile.new(__FILE__)
  #   client.send_document(chat_id: message.chat.id, document: file)

  # when /send_sticker/
  #   file = Telebot::InputFile.new(fixture("zamenhof_sticker.webp"))
  #   client.send_sticker(chat_id: message.chat.id, sticker: file)

  # when /send_video/
  #   file_id = "BAADAgADOQADqwcsBcskdD5ZfXZyAg"
  #   client.send_video(chat_id: message.chat.id, video: file_id)

  # when /send_location/
  #   client.send_location(chat_id: message.chat.id, latitude: 53.131684, longitude: 23.169556)

  # when /send_chat_action/
  #   client.send_message(chat_id: message.chat.id, text: "Check my status, I am typing")
  #   client.send_chat_action(chat_id: message.chat.id, action: :typing)
  #   sleep 3
  #   client.send_message(chat_id: message.chat.id, text: "Done")

  # when /get_user_profile_photos/
  #   photos = client.get_user_profile_photos(user_id: message.from.id)
  #   if photos.total_count > 0
  #     client.send_message(chat_id: message.chat.id, text: "Look at yourself!")
  #     photo = photos.photos.first
  #     photo_size = photo.first
  #     client.send_photo(chat_id: message.chat.id, photo: photo_size.file_id)
  #   else
  #     client.send_message(chat_id: message.chat.id, text: "Your profile has no photos")
  #   end

  else

    client.send_message(chat_id: message.chat.id, text: 'Unknown command', reply_markup: markup)
  end
end