# MEHEDY — 900 Command Catalogue

এই প্রজেক্টে `public/commands.json` ফাইলে 900টি catalogue entry রাখা হয়েছে, 30টি category-তে ভাগ করা।

## Website Demo
Local server চালু করে `http://localhost:3000/commands.html` খুলুন।

প্রতিটি command card-এ click করলে:
- Command syntax
- কাজের বিবরণ
- Example
- Permission
- Demo / implementation status

দেখা যাবে।

## Status-এর অর্থ
- Working: handler source code-এ আছে; বাস্তব WhatsApp account-এ live test দরকার।
- Requires setup: external API/provider/configuration দরকার।
- Planned: এখনো command handler লেখা হয়নি।

## গুরুত্বপূর্ণ
900টি catalogue entry মানে 900টি live executable command নয়। এই version-এ 20টি command handler আছে। বাকি command একে একে implement, review এবং test করতে হবে। কোনো feature-কে working বলা হবে না যতক্ষণ না তার code এবং test সম্পন্ন হয়।
