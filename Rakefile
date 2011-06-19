require 'rubygems'
require "active_record"
require './server.rb'

dbconfig = YAML.load(File.read('config/database.yml'))
env = ENV['SINATRA_ENV'] || 'production'
ActiveRecord::Base.establish_connection dbconfig[env]

namespace :db do
  desc "Migrate the database"
  task(:prepare) do
    ActiveRecord::Schema.define do

      create_table "users", :force => true do |t|    
        t.column "id_string", :string    
        t.column "email", :string
        t.column "lat", :float
        t.column "lng", :float
        t.column "contact_method", :string
        t.column "postal_code", :string
        t.timestamps 
      end

      create_table "posts", :force => true do |t|    
        t.column "i_got", :text
        t.column "u_got", :text
        t.column "contact_method", :text
        t.column "email", :text
        t.column "secret_id", :string
        t.column "lat", :float
        t.column "lng", :float
        t.column "user_id", :integer
        t.timestamps 
      end

      create_table "tags", :force => true do |t|    
        t.column "name", :string 
        t.timestamps 
      end
      create_table "taggings", :force => true do |t|    
        t.column "tag_id", :integer
        t.column "post_id", :integer
        t.column "user_id", :integer
        t.timestamps 
      end



    end
  end 

  desc "Fill with noise"
  task(:fill) do
    jabberwock = <<-JABBER
    <font size="+2"> 
    `Twas brillig, and the slithy toves<br> 
    &nbsp;&nbsp;Did gyre and gimble in the wabe:<br> 
    All mimsy were the borogoves,<br> 
    &nbsp;&nbsp;And the mome raths outgrabe.<p> 
    </center> 

    <img src="/pics/jabberwocky.jpg" align="right" border=0 width=291 
    height=432> 

    <p><br> 

    "Beware the Jabberwock, my son!<br> 
    &nbsp;&nbsp;The jaws that bite, the claws that catch!<br> 
    Beware the Jubjub bird, and shun<br> 
    &nbsp;&nbsp;The frumious Bandersnatch!"<br> 

    <p> 

    He took his vorpal sword in hand:<br> 
    &nbsp;&nbsp;Long time the manxome foe he sought --<br> 
    So rested he by the Tumtum tree,<br> 
    &nbsp;&nbsp;And stood awhile in thought.<br> 

    <p> 

    And, as in uffish thought he stood,<br> 
    &nbsp;&nbsp;The Jabberwock, with eyes of flame,<br> 
    Came whiffling through the tulgey wood,<br> 
    &nbsp;&nbsp;And burbled as it came!<br> 

    <p> 

    One, two!  One, two!  And through and through<br> 
    &nbsp;&nbsp;The vorpal blade went snicker-snack!<br> 
    He left it dead, and with its head<br> 
    &nbsp;&nbsp;He went galumphing back.<br> 

    <p> 

    "And, has thou slain the Jabberwock?<br> 
    &nbsp;&nbsp;Come to my arms, my beamish boy!<br> 
    O frabjous day!  Callooh!  Callay!'<br> 
    &nbsp;&nbsp;He chortled in his joy.<br> 

    <br clear="all"><center><br> 

    `Twas brillig, and the slithy toves<br> 
    &nbsp;&nbsp;Did gyre and gimble in the wabe;<br> 
    All mimsy were the borogoves,<br> 
    &nbsp;&nbsp;And the mome raths outgrabe.

    <p>
    JABBER
    haves = ['fairy king prawn', 'bubblegum fellow', 'saga novel', 'orion the thanks', 'grass world', 'air eminem', 'air jihad', 'Ibuki Government', 'Fine Motion', 'Broad Appeal', jabberwock]
    wants = ['carrots', 'eggs', 'spinach', 'rhubarb', 'so much fucking rhubarb', 'beans', 'a new frying pan', 'basil', 'honey', 'ektorp', 'zuchinni', 'cukes', 'rabbits', 'let us', 'lettuce']
    tags = ['good', 'bad', 'ugly', 'sketchy', 'so good', 'so bad', 'so ugly', 'so sketchy', 'do it motherfucker']
    names = ["Dr. Clarabelle Casper", "Ms. Uriel Zboncak", "Rhea Corwin I", "Miss Chester Kovacek", "Erling Dicki", "Frieda Lakin", "Dr. Gayle Blanda", "Dr. Florian Block", "Dax Kling", "Reva Crona", "Annette Fritsch III", "Nettie Stiedemann", "Glenna Rempel", "Gail Ward", "Bernadine Strosin", "Ms. Craig Kulas", "Johnnie Auer", "Jennie Watsica", "Roslyn Towne", "Tristian Conn III", "Ansley Gleichner", "Marshall Koelpin", "Earl Lang Jr.", "Colby Purdy", "Mortimer Feil Jr.", "Brandyn Anderson PhD", "Flavio Williamson", "Ms. Emma Schmitt", "Clifton Donnelly DDS", "Dr. Lucio Eichmann", "Dr. Iliana Hirthe", "Steve Adams DDS", "Isabella Hauck MD", "Miss Nikko Strosin", "Ora Bartoletti", "Carol Kassulke V", "Ethelyn Miller", "Sydnie Roberts", "Mr. Patsy O'Hara", "Tyrel Reichel", "Caleb Armstrong", "Cedrick Oberbrunner DVM", "Alessandro Nienow", "Camilla Considine", "Edd Bailey V", "Renee Schinner", "Randal Shanahan I", "Delphia Walker", "Ms. Audra Thompson", "Verdie Shields DVM", "Misty Rutherford", "Tremaine Pouros", "Garth Gutmann", "Loren Hammes", "Yvette Gottlieb", "Carter Nikolaus", "Dr. Karlie Fritsch", "Kari Lynch", "Chaz Parisian I", "Omari King DVM", "Nathaniel Collier", "Robyn Gorczany", "Savannah Rohan", "Ms. Marilie Metz", "Kelli Gerlach", "Luz Nitzsche", "Velva Bruen", "Sammy Altenwerth", "Mr. Jonathon Ebert", "Kailey Monahan", "Ramiro Jacobi", "Murray Runte", "Zachary Weissnat", "Gaetano Glover", "Nicklaus Kuhic", "Cayla Bosco", "Olen Raynor PhD", "Mr. Abagail Senger", "Mrs. Arvilla Walsh", "Ceasar Mayert", "Gia Wiza", "Heath Schiller", "Lulu Braun", "Kacie Paucek", "Zula Rosenbaum V", "Vickie Ledner DDS", "Mrs. Taylor Bashirian", "Saige Bergnaum", "Simone Lynch", "Elton Dietrich", "Demetris Schaden", "Cordia Will", "Miss Wyman Tremblay", "Vivien Gusikowski", "Bernie Fay", "Sydney Fay", "Mrs. Stewart Harvey", "Ms. Lance Roberts", "Luciano Raynor", "Destiny Fahey"]
    email = ["ila_tillman@oconnell.net", "tomas.king@friesen.org", "raoul_goldner@pollich.biz", "carli@wuckertrau.org", "axel.rodriguez@cruickshank.name", "richard_schinner@champlinleannon.org", "bonnie.larson@ohara.biz", "oscar@kuhlman.com", "dante@gleichner.org", "bridie@beahan.org", "delbert_leannon@runolfsson.biz", "rick.oconner@glover.net", "margret@hagenesvandervort.net", "abdullah@schuppe.com", "madison@gloverstokes.name", "teresa.lowe@hermann.name", "nicholaus@renner.com", "kristina@nienow.net", "alexanne.haag@eichmann.biz", "keyshawn_pouros@kemmer.info", "whitney@ratke.info", "rick_becker@gerholdmacejkovic.org", "kyra@pacochawill.name", "kelli.kulas@kubstoltenberg.com", "johnson@pollich.org", "jaylan@bartellhyatt.org", "milford@dickimurazik.org", "clare@balistreri.com", "nicola_dooley@spencer.info", "jayne@upton.name", "blair.konopelski@schillerwaelchi.org", "florida_wisozk@cremin.com", "camryn.mertz@lubowitzschulist.org", "kyler@steuberlind.net", "josue_morar@schiller.net", "xavier@parisian.info", "tristin.feil@gibson.name", "fritz_osinski@nitzschegleichner.net", "kareem_glover@brekke.info", "rigoberto@ratke.org", "aracely@fadel.org", "brendan@dubuque.org", "bart@greenfelderkuvalis.name", "corene@schaden.biz", "webster.hickle@beckerwisozk.name", "leila@jacobs.name", "flossie@bailey.com", "margot@millerpredovic.info", "zakary@harber.info", "lucinda_gutkowski@botsford.org", "rosamond@treutel.biz", "hester.thompson@pacocha.org", "ora.spencer@aufderhar.info", "bud@jerde.net", "madilyn@mann.info", "maci@trantowterry.biz", "sedrick_rippin@nolan.com", "amiya.orn@rodriguez.name", "delfina@kub.org", "iliana_leuschke@douglas.net", "lillian.fay@schmeler.net", "loyal@howecrist.com", "kareem@hauck.com", "reta_howell@crooks.biz", "alfred@brown.name", "william@waelchischneider.name", "elena.greenholt@aufderhar.net", "judy_ortiz@stammlehner.net", "garett.feeney@nicolas.name", "marilou.dibbert@bruen.net", "tamia_gerlach@cormier.biz", "kareem_nienow@breitenberg.com", "dejon.cruickshank@huelsrath.biz", "corene_denesik@littleheathcote.com", "asha@hammesdach.biz", "aurelio@heathcote.info", "erik@tremblaycollins.com", "seamus@schulist.biz", "ken.roob@beattystroman.com", "bernice@altenwerth.com", "trace.little@mclaughlinzieme.net", "brown_weissnat@greenfelder.info", "emmie_batz@mante.name", "katelynn.morar@bergnaum.info", "maud.yost@bechtelar.biz", "gilbert.fisher@gulgowski.org", "laurianne_harber@runolfsdottir.org", "litzy@hermanhuels.name", "kristian@padberg.biz", "delores_larson@schinner.info", "jordy.abshire@walshwaters.name", "keara@adamspowlowski.com", "rebecca_altenwerth@kochcrooks.biz", "jamel@mrazkub.biz", "raphael@kovacek.info", "vincenzo@purdy.biz", "jarret.jenkins@miller.net", "glen.rice@okunevagottlieb.name", "elza.ruecker@turcotte.name", "lila.williamson@skilessimonis.name"]
    phone  = ["(733)916-7078 x55509", "1-197-085-4996 x385", "622.112.0744 x28640", "381.323.9057 x79940", "1-943-259-8714 x034", "(929)281-5587 x7915", "1-633-347-1133", "(584)576-8449 x473", "1-897-577-8239", "1-183-749-0668 x38583", "1-248-463-3661", "843.522.9003", "1-726-417-8757", "1-201-589-4828 x9435", "1-213-006-0928", "1-547-141-1806", "1-329-958-5914 x175", "1-286-582-9931", "499.816.6683 x612", "1-212-072-5151 x6905", "845-528-8223 x9655", "1-454-631-0244 x661", "464-149-3031", "351-605-8405 x014", "145.468.7729 x396", "1-226-463-8328", "1-397-790-7422 x16119", "1-666-659-8867 x2434", "1-078-252-7339", "005.200.4078", "721.199.0257 x24131", "315-960-9551 x344", "1-271-603-8861 x85752", "647-469-6175", "031-331-0341", "906-632-4775 x9414", "146-682-7236 x84675", "1-624-810-6960", "814.370.3800", "969-456-4465 x663", "(344)441-9308 x62189", "1-031-480-0639 x3030", "606-557-6390 x8116", "923.776.3335", "778.232.3066", "401-978-6255", "962.604.8760", "885.053.4263 x2457", "143.640.5334 x751", "175.481.5828", "1-832-022-8384 x20087", "1-383-047-9779", "1-694-526-3705 x76769", "(120)284-6722 x03328", "617.320.2787 x76849", "348-580-4777 x807", "539.740.9514", "891-704-0045", "1-419-627-2989", "467.648.9416", "1-635-043-1216 x52131", "(865)849-6552 x62609", "766.821.4747 x11373", "318-247-4936 x75020", "026.498.5927 x26268", "(852)638-4422 x171", "(828)868-7297 x689", "389-735-9653", "(178)344-3153 x495", "741-902-3535 x24879", "908.493.7515", "1-129-590-2862", "(149)860-3927", "(281)387-9663", "(039)138-1186 x9305", "049-599-0900", "886.098.7785 x300", "1-783-362-8286 x747", "655-011-0765", "192.667.1692", "405.070.0491 x5747", "682-286-3534 x1327", "013.612.3210 x788", "(748)879-0731", "271-588-9477", "(107)851-9677", "921-622-5552 x96266", "1-926-656-2936", "1-479-794-8686", "(828)464-2722 x28377", "652.919.1648 x89866", "(997)353-5906 x994", "855-295-0921 x5792", "(699)590-8829", "1-582-525-2877 x351", "836.448.0751 x5711", "473.854.7915", "(902)346-6519 x845", "(902)795-1204 x822", "333-688-8140"]
    amounts = ['a handful of', 'a pound of', 'a wheelbarrel of', 'so much', 'so fucking much', 'a bit of', 'hella', 'hecka', 'a shit-tonne of']
    contacts = ["on my phone #{phone[rand(phone.length)]}", "to my email, #{email[rand(email.length)]}", "beep me, #{phone[rand(phone.length)]}"]
    
    100.times do
      post = Post.create(
               :i_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]} and A horse named #{haves[rand(haves.length)]}", 
               :u_got => "#{amounts[rand(amounts.length)]} #{wants[rand(wants.length)]} ",
               :contact_method => contacts[rand(contacts.length)],
               :lat => "34.10300320 - (rand() * 5)", 
               :lng => "-118.41046840 - (rand() * 5)")
      rand(4).times { 
        begin 
          post.tags << Tag.find_or_create_by_name(:name => tags[rand(tags.length)])
        rescue
        end   
          }
      
    end
  end
end
