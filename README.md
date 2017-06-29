# Ortak Anahtar Altyapıları (PKI)
> Ortak Anahtar Altyapıları ve Açık Kaynaklı Uygulamalar İçin Bir Rehber

<details>
The Open–source PKI Book (https://sourceforge.net/projects/ospkibook/files/ospkibook/2.4.7/OSPKI-DOCS-2.4.7.tar.gz/download)
A guide to PKIs and Open–source Implementations
</details>

## Bölüm 1. Bu belgenin amacı

Bu belge, Ortak Anahtar Altyapıları (PKI) ve PKI'lerin teorik ve pratik açıklamalarına odaklanmaktadır

Belirli standartlarla ilişkili olarak [PKIX Çalışma Grubunun](https://datatracker.ietf.org/wg//pkix-charter.html) çalışmaları sunulmaktadır. Bu standartları irdeleme ve uygulamaları uyum derecesine göre sınıflandırılması amaçlanmıştır.

Bu belge, açık anahtar şifrelemesi üzerine genel bir giriş ile başlar. Ardından, özelliklikleri karşılaştırarak birçok genel uygulamayı açıklar.

PKI'lara uygun güvenlik konularında bir tartışma daha var.

Örnek Uygulamalar, protokolleri test etmek, geribildirim kaynağı sağlamak ve kişinin PKI'lerin harika dünyasıyla ilgili daha fazla bilgi edinmesini sağlamak için bir eğitim aracı olarak sunulmaktadır.

<details>
## Chapter 1. Purpose of this document

With relation to specific standards, the work of the PKIX Working Group (https://datatracker.ietf.org/wg//pkix-charter.html) is presented. There is an emphasis on these standards and there is an attempt to classify implementations according to the degree of compliance.

This document starts with an introduction on public–key cryptography. Then, it describes several publicly available implementations providing a feature by feature comparison.

There is a further discussion on security issues with accordance with PKIs.

The implementations are presented as an educational instrument to test the protocols, to provide a source of feedback and to enable the individual to learn more about the wonderfull world of PKIs.

> Note: The latest version of this document can be found at the OSPKI Book WWW site (https://sourceforge.net/projects/ospkibook/)
</details>

## Bölüm 2. Kriptografiye Giriş

İletişim yaşamın vazgeçilmez bir parçasıdır. İnsanoğlunun gelişimini işaret ettiğini söyleyebiliriz. İletişim; geleneksel olarak posta yoluyla mektup göndermek, Telekomünikasyon şirketi aracılığıyla telefonla konuşmak ya da daha yaygın olarak - doğrudan diğer kişiyle konuşmaktır. Bu geleneksel yöntemler uzun bir süre var olmuştur ve insanlar, kişisel ya da ticari iletişime yönelik güvenli bir iletişim kurabilmeleri için özel yöntemler geliştirmiştir. Yüz yüze iletişim için, insanlar birbirlerinin fiziksel özelliklerini tanıyabilir veya elle yazılmış imzaları bir kimlik kartı gibi resmi belgelerle karşılaştırabilirler. Bir kişinin tüm fiziksel özelliklerini taklit etmek zordur. İnsanlar birbierinin kimliğini öncelikli olarak kabul edebilir. İmzanın taklit edilmesi zordur ve takliti bir suç olarak tanımlayan kanunlar vardır. Sonuçta her iletişim ortamı için, insanların güvenli ve şeffaf bir şekilde iletişim kurabilmesine yönelik belirli yasalar ve teknolojilerin belirlendiği bir geçiş dönemi olmuştur.

İnternet, dünyadaki bilgisayar ağlarını birbirine bağlayan bir ağ olarak, diğerlerine göre önemli ölçüde farklı yeni bir iletişim ortamıdır. Örneğin, internette, iletişim kuran tarafların fiziksel teması yoktur. Bir kişinin başkası olarak kılık değiştirmesi, ses ve diğer yönlerini taklit etmesi ve daha önceki ortak deneyimler hakkında bilgi edinmesi oldukça zordur. Ancak Online işlemler bu gayri meşru faaliyetleri engelleyememektedir. Buna ek olarak, Internet'te, yüksek kazançlar vaad eden aynı dolandırıcılık türlerini otomatikleştirmekte mümkündür. Bu noktada şeffaf ve güvenli iletişim kurmanın yasası ve teknolojileri tam olarak tanımlanmamış veya henüz belirlenmemiştir.

Kriptografi, kimlik belgesi veya bir resmi belgeye atılan ıslak imza gibi dijital sertifikaların işlevselliğine benzeyen dijital kimlik belgelerini sağlamıştır. Ancak, bu teknolojileri kullanabilmek için, kullanımlarının eşit derecede şeffaf ve güvenli olmasını sağlayacak gerekli yönergeleri yerine getirmemiz gerekmektedir.

İmtiyazlı Yönetim Altyapısı (Priviledge Management Infrastructure) ile birlikte Kamu Anahtar Altyapıları (The Public Key Infrastructures), Internet'in bu şeffaflığına ve güvenliğine yardımcı olacak adaylardır. Bu kavramların her ikisi de Bölüm 6'da açıklanmaktadır.

Kriptografi için aşağıdaki girişin büyük bir kısmı, Frederick J. Hirsch tarafından yazılan SSLeay Sertifika El Kitabından alınmıştır.

<details>
##Chapter 2. Introduction to Cryptography

Communication is an essential part of life. We can say that it marks the progress of human beings. Traditional media for communication are the sending of letters through the Post Office, talking over the phone through the Telecommunications company, or – more commonly – to speak directly with the other person. These traditional media have existed for a long period of time and special provisions have been made so that people can communicate in a secure way, either for personal or for business communication. For face–to–face communication, people can recognise each other’s physical characteristics or they can compare hand–written signatures with that of official documents like an ID card. Mimicking all of the physical characteristics of a person is difficult. People can accept with a high level of certainty the identity of their colleague. Signature forging is difficult and there are laws that define forging as a crime. The bottom line is that for each communication medium, there is a transitional period when specific laws and technologies are set in order for people to communicate securely and transparently.

The Internet, as a network that interconnects networks of computers around the world, is a new communication medium that is substantially different from existing ones. For example, on the Internet, the communicating parties do not have physical contact. It is rather more difficult for one to disguise oneself to someone else, immitate the voice and other aspects behaviour and get information on prior common experiences. On–line transactions do not impose such barriers for illegitimate transactions. Additionally, on the Internet, one can automate the same type of fraud bringing higher gains and a bigger incentive. The law and the technologies to let transparent and secure communication have not been fully defined or set yet.

Cryptography has provided us with digitalsignatures that resemble in functionality the hand–written signatures and digital certificates that relate to an ID card or some other official document. However, in order to use these technologies, we need to make the necessary provisions so that their usage is equally transparent and secure.

The Public Key Infrastructures along with the Priviledge Management Infrastructure are candidates to aid this transparency and security of applications of the Internet. Both of these concepts are described in Chapter 6.

Big parts of the following introduction to cryptography has been taken from the SSLeay Certificate Cookbook, written by Frederick J. Hirsch.
</details>


### 2.1. Şifreleme Algoritmaları

Kriptografinin saf matematikten birkaç farklılığı vardır. Bunlardan biri, kriptografinin ders kitaplarında daha açıklayıcı olmasıdır. Bir algoritmayı açıklamak için bir matematikçi A ve B'yi kullanabilirken, bir şifreleme uzmanı Alice ve Bob gibi hayali isimleri kullanabilir. Bundan dolayı sonraki bölümlerde, Alice ve Bob isimleri rasgele seçilmemiştir; Neredeyse tüm kriptografi ders kitaplarında bulunabilirler.

Alice'in para transfer etmek için bankasına bir mesaj göndermek istediğini varsayalım. Alice, hesap numarası ve transfer miktarı gibi bilgileri içeren mesajın gizli olmasını ister. Bir çözüm, mesajını şifrelenmiş bir forma dönüştürmek için tasarlanmış bir kriptografik algoritma kullanmaktır. Mesaj şifreli olduğunda,  sadece karşılık gelen gizli anahtar kullanılarak yorumlanabilir. Anahtar olmadan, mesaj işe yaramaz: İyi şifreleme algoritmaları, davetsiz misafirlerin orijinal metni şifresiz bir şekilde çözmelerini zorlaştırır.

Kriptografik algoritmalar için iki kategori vardır: klasik şifreleme (conventional) ve genel anahtar (public key).

Simetrik şifreleme olarak da bilinen klasik şifreleme, gönderen ve alıcının bir anahtarı paylaşmasını gerektirir: iletiyi şifrelemek veya şifresini çözmek için kullanılan gizli bir bilgi parçası. Bu anahtar gizli ise, gönderen veya alıcıdan başka kimse mesajı okuyamaz. Alice ve banka bu gizli anahtara sahipse, o zaman birbirlerine özel mesajlar gönderebilirler. Bununla birlikte, iletişim kurmadan önce özel bir anahtar seçme görevi sorunlu olabilir.

Açık anahtar şifrelemesi, asimetrik şifreleme olarak da bilinir ve her biri bir iletiyi şifrelemek için kullanılabilen iki anahtar kullanan bir algoritma tanımlayarak anahtar değişimi sorununu çözer. Bir iletiyi şifrelemek için bir anahtar kullanılırsa, iletinin şifresini çözmek için diğeri kullanılmalıdır. Bu, yalnızca bir anahtar (public key - genel anahtar) yayınlayarak ve diğer gizli (özel anahtar - private key) tutarak güvenli iletileri almanızı sağlar.

Herkes bir iletiyi genel anahtar kullanarak şifreleyebilir, ancak yalnızca özel anahtarın sahibi onu okuyabilir. Bu şekilde Alice, açık anahtarlarını kullanarak şifreleyerek bir anahtar çiftinin (banka) sahibine özel mesajlar gönderebilir. Böylece sadece banka şifreyi çözebilir.

Açık anahtar algoritmalarına örnekler Ek C'de bulunabilir.


<details>
### 2.1. Cryptographic Algorithms

Cryptography has several differences from pure mathematics. One of these is that cryptography is more descriptive in its textbooks. While a mathematician may use A and B to explain an algorithm, a cryptographer may use the fictious names Alice and Bob. Thus, in the next sections, the names Alice and Bob are not randomly chosen; they can be found in almost all cryptography textbooks.

Suppose Alice wants to send a message to her bank to transfer money. Alice would like the message to be private, since it includes information such as her account number and transfer amount. One solution is to use a cryptographic algorithm, a technique that would transform her message into an encrypted form, unreadable except by those for whom it is intended. When encrypted, the message can only be interpreted through the use of the corresponding secret key. Without the key the message is useless: good cryptographic algorithms make it so difficult for intruders to decode the original text that it isn’t worth their effort.

There are two categories of cryptographic algorithms: conventional and public key.

Conventional cryptography, also known as symmetric cryptography, requires that the sender and receiver share a key: a secret piece of information that is used to encrypt or decrypt a message. If this key is secret, then nobody other than the sender or receiver can read the message. If Alice and the bank each has a secret key, then they may send each other private messages. The task of privately choosing a key before communicating, however, can be problematic.

Public key cryptography, also known as asymmetric cryptography, solves the key exchange problem by defining an algorithm which uses two keys, each of which can be used to encrypt a message. If one key is used to encrypt a message, then the other must be used to decrypt it. This makes it possible to receive secure messages by simply publishing one key (the public key) and keeping the other secret (the private key).

Anyone may encrypt a message using the public key, but only the owner of the private key is able to read it. In this way, Alice may send private messages to the owner of a key–pair (the bank) by encrypting it using their public key. Only the bank can decrypt it.

Examples of public–key algorithms can be found at Appendix C.
</details>

### 2.2. Mesaj Özetleri

Her ne kadar Alice mesajını gizli hale getirmek için şifrelese de, örneğin, birisinin orijinal mesajını değiştirebileceği ya da parayı kendilerine aktarabilmek için başka bir mesajla değiştirmesi endişesi söz konusudur. Alice'in mesajının bütünlüğünü garanti altına almanın bir yolu, mesajının kısa bir özetini oluşturmak ve bunu bankaya da göndermektir. Mesajı aldıktan sonra, banka kendi özetini oluşturur ve Alice'in aldığı özetle karşılaştırır. Kabul ederse, mesaj bozulmadan alınıyordu.

Buna bir özet, bir ileti özeti, tek yönlü işlev veya hash işlevi denir. İleti özetleri, daha uzun, değişken uzunluklu iletilerin kısa, sabit uzunlukta gösterimlerini oluşturur. Özet algoritmaları, farklı mesajlar için benzersiz özetler üretmek üzere tasarlanmıştır. İleti özetleri, özetten gelen iletiyi belirlemeyi zorlaştırıyor ve aynı özeti oluşturan iki farklı ileti bulmakta zorlanıyor - aynı özet akışını korurken aynı iletiyi bir başkasıyla değiştirme olasılığını ortadan kaldırıyor.

Alice'in karşı karşıya kaldığı bir diğer zorluk, özeti bankaya güvenli bir şekilde göndermenin bir yolunu bulmaktır; Bu gerçekleştiğinde, ilişkili mesajın bütünlüğü garanti edilir. Bunun bir yolunu özete bir dijital imza eklemektir.

<details>
2.2. Message Digests

Although Alice may encrypt her message to make it private, there is still a concern that someone might modify her original message message or substitute it with a different one in order to transfer the money to themselves, for instance. One way of guaranteeing the integrity of Alice’s message is to create a concise summary of her message and send this to the bank as well. Upon receipt of the message, the bank creates its own summary and compares it with the one Alice sent. If they agree then the message was received intact.

A summary such as this is called a message digest, one–way function, or hash function. Message digests create short, fixed–length representations of longer, variable–length messages. Digest algorithms are designed to produce unique digests for different messages. Message digests make it difficult to determine the message from the digest, and difficult to find two different messages which create the same digest –– eliminating the possibility of substituting one message for another while maintaining the same digest.

Another challenge that Alice faces is finding a way to send the digest to the bank securely; when this is achieved, the integrity of the associated message is assured. One way to to this is to include the digest in a digital signature.
</details>

### 2.3. Dijital İmzalar

Alice, bankaya bir mesaj gönderdiğinde, bankanın mesajın gerçekten kendisinden geldiğini ve hesabı içeren bir işlem talep eden bir saldırganın olmadığını kontrol etmesi gerekir. Alice tarafından oluşturulan ve mesajla birlikte gelen bir dijital imza, bu amaca hizmet eder.

Dijital imzalar, iletinin bir özetini ve gönderenin özel anahtarı ile diğer bilgileri (örneğin bir sıra numarası) şifreleyerek oluşturulur. Herkes herkese açık anahtarı kullanarak imza şifresini çözebilir, ancak imzalayan yalnızca özel anahtarı bilir. Bu sadece imza sahibinin imzalamasını sağlar. İmza içerisine sindirmayı eklemek imza sadece o mesaj için iyi demektir; Kimsenin özeti değiştiremeyeceği ve imzalamayabildiğinden mesajın bütünlüğünü de sağlar.

İmzanın daha sonraki bir tarihte bir saldırgan tarafından engellenip tekrar kullanılmasını önlemek için, imza benzersiz bir sıra numarası içerir. Bu, bankayı, Alice'in aldattığı iddiadan mesajı göndermediğini - yalnızca imzalamış olabileceği (reddedilemediği) korur.

<details>
2.3. Digital Signatures

When Alice sends a message to the bank, the bank needs to ensure that the message is really from her, and not an intruder requesting a transaction involving her account. A digital signature, created by Alice and included with the message, serves this purpose.

Digital signatures are created by encrypting a digest of the message, and other information (such as a sequence number) with the sender’s private key. Though anyone may decrypt the signature using the public key, only the signer knows the private key. This ensures that only the signator signed it. Including the digest in the signature means the signature is only good for that message; it also ensures the integrity of the message since no one can change the digest and still sign it.

To guard against interception and reuse of the signature by an intruder at a later date, the signature contains an unique sequence number. This protects the bank from a fraudulent claim from Alice that she did not send the message –– only she could have signed it (non–repudiation).
</details>

### 2.4. Sertifikalar

Her ne kadar Alice bankaya özel bir mesaj yollamış olsaydı, imzalamış ve mesajın bütünlüğünü sağlamış olsa da, bankayla gerçekten iletişimde olduğundan emin olmalı. Bu, kullandığı ortak anahtarın bankanın özel anahtarıyla aynı olduğundan emin olması gerektiğini ifade eder. Benzer şekilde, bankanın mesaj imzasının gerçekten Alice imzasına karşılık geldiğini de doğrulaması gerekmektedir.

Her bir tarafın diğerinin kimliğini doğrulayan, ortak anahtarını onaylayan ve güvenilir bir ajans tarafından imzalanmış bir sertifikası varsa, ikisi de kendilerinin kime ait olduğunu düşünen kişiyle iletişim kurduğundan eminler. Her bir taraf, diğer tarafın sertifikasını doğrulamak ve daha sonra kullanıcıların ortak anahtarının güvenilirliğini sağlamak için güvenilir ajansın genel anahtarını kullanır.

<details>
2.4. Certificates

Although Alice could have sent a private message to the bank, signed it, and ensured the integrity of the message, she still needs to be sure that she is really communicating with the bank. This means that she needs to be sure that the public key she is using corresponds to the bank’s private key. Similarly, the bank also needs to verify that the message signature really corresponds to Alice’s signature.

If each party has a certificate which validates the other’s identity, confirms the public key, and is signed by a trusted agency, then they both are assured that they are communicating with whom they think they are. Each party uses the public key of the trusted agency to verify the certificate of the other party and subsequently to ensure the authenticity of the users’ public key.
</details>

### 2.5. Sertifika Yetkilisi

Sertifikalarını özel anahtarıyla imzalayan ve başkalarının Sertifikaları karşılık gelen genel anahtar kullanarak doğrulamasına izin veren güvenilir kuruma, Sertifika Yetkilisi veya CA adı verilir. Güvenilir olabilmek için, iki tarafın herhangi biriyle ortak çıkarları olmaması gerektiği düşünülen bu Sertifikasyon Otoritesi, Güvenilir Üçüncü Şahıs (TTP) olarak da bilinir.

> Not: Bir bankanın bir Sertifika Yetkilisi olmaması ve ayrıca ekonomik işlem yaptığınız taraf olması gerektiği düşünülmektedir. Bunun nedeni, bir CA olarak kendisiyle lehte olabilir, kendisi ile bir iş yaptığı bir partidir.

Bu belgede, Sertifika Yetkilisinin teknik yönleri üzerinde yoğunlaşıyoruz.

<details>
2.5. Certification Authority

The trusted agency that signs Certificates with its private key and lets others verify Certificates by the usage of the corresponding public key is called a Certification Authority, or CA. This Certification Authority is also known as a Trusted Third Party (TTP), since it is regarded that, in order to be trusted, it should not have common interests with any of the two parties.

> Note: It is believed that a bank should not be a Certification Authority and also be the party that you make economic transactions with. They reason is that, as a CA, it can favor itself, as a party one does business with.

In this document we concentrate on the technical aspects of the Certification Authority
</details>



## Bölüm 3. Bir Genel Anahtar Altyapısının temel işlevleri [TODO]

Alice, Bob'la güvenli bir şekilde iletişim kurmak istiyor. Özünde, bu, Alice'in başkasının konuşmayı dinlemesini istemediği, Bob'a gönderilen bilgilerin kendisine doğru yolda değiştirilmemesi ve sonunda bu konuşmayı kanıtlayacak bir mekanizmanın olmasını istemek anlamına gelir. Durum, bir nedenle, istemediğini iddia ediyor. Sertifika Yetkilisini kullanarak iletişim kurmak için gerekli tüm adımları anlatacağız.

<details>
Chapter 3. Basic functionality of a Public Key Infrastructure[TODO]

Alice wants to communicate securely with Bob. In essence, this means that Alice does not want someone else to listen to the conversation, wants the information sent to Bob not to be altered on their way to him and finally she would possibly like a mechanism to prove that she had this conversation, in case, for some reason, claim he did not. We shall describe all the steps necessary to establish communication using the Certification Authority. 
</details>




### 3.1. Anahtar çiftinin oluşturulması ve sertifika isteği

Alice, RSA gibi bir genel anahtar algoritması kullanarak bir ortak / özel anahtar çifti oluşturur. Ardından, Sertifika Yetkilisi tarafından imzalanmadan hemen önce Sertifika olan bir sertifika isteği oluşturur. İlk olarak, sertifika isteği, kullanıcının kimliği hakkında, ad, adres, telefon numarası ve e-posta adresi gibi bilgileri içerir. İkincisi, genel anahtarını içeriyor. Sertifikalar, sadece bir WWW sunucusu veya bir ağ aygıtı gibi kişileri değil, genel olarak kimlikleri doğrulamak için kullanılabilir. İkinci durumda, Sertifika'ndaki bilgiler WWW sunucusunun URL'si, WWW Yöneticisi ayrıntıları vb. Olur.

<details>
3.1. Creation of the key–pair and the certificate request

Alice creates a public/private key pair using a public key algorithm like RSA. Then, she creates a certificate request, which is the Certificate just prior to signing by the Certification Authority. First, the certificate request contains information about the identity of the user, such as the name, address, telephone number and e–mail address. Second, it contains her public key. Certificates can be used to authenticate not only people but also entities in general, such as a WWW server or a network device. In the latter case, the information in the Certificate would be the URL of the WWW server, the WWW Administrator details, and so on. 
</details>

### 3.2. Sertifika Yetkilisi tarafından sertifika isteğinin imzalanması

Alice, sertifika talebini imza için Kayıt Otoritesine gönderir. Herhangi bir onay veya reddetme eylemi Kayıt Kuruluşında yapılır. Ardından, RA, politika onayı ve imzalanması için CA'ya talebi gönderir. İmzalamanın sonucu - Sertifika - Kayıt Kuruluşu vasıtasıyla Alice'e gönderilir. Ayrıca genellikle bir Dizin Sunucusu'nda saklanırlar.

<details>
3.2. Signing of the certificate request by the Certification Authority

Alice sends her certificate request to the Registration Authority for its signature. Any action of approval or disapproval takes place at the Registration Authority. Then, the RA sends the request to the CA for policy approval and to be signed. The result of the signing –– the Certificate –– is sent back to Alice through the Registration Authority. They also are often stored on a Directory Server. 
</details>

### 3.3. Sertifika Yetkilisi zincirleri
Bu sertifikayı kullanarak Alice, genel anahtarının güvenilir olduğunu iddia edebilir. Onunla iletişim kurmak isteyen Bob, Sertifikasını ister. Bob, Sertifikasını doğrulamak için Alice'in genel anahtarını imzalayan Sertifika Yetkilisinin genel anahtarını bulur. Bunu güvenli bir şekilde yapması gerekiyor. Eğer ikisi de aynı Sertifika Otoritesinde bulunuyorsa o zaten zaten vardır. Değilse, Sertifika Otoritesi'nden açık anahtar için diğer Sertifika Yetkilisine başvurmasını ister. Bob'un Sertifika Yetkilisi, her Sertifika Yetkilisi için bir önceki anahtarın genel anahtarına ihtiyaç duyar, böylece anahtarın güvenilirliği garanti altına alınır. Diğer Sertifika Otoritesine yol açan bir zincir bulunursa, iletişim kurulabilir.

> Not: CA'lar arası güven sorunu çok önemlidir; zira kötü bir CA, tüm altyapının güvenliğini baltalayabilir. Burada bu konu ele alınmamıştır (en azından bu sürümde).

<details>
3.3. Certification Authority chains

Using this certificate, Alice can claim that her public key is trustworthy. Bob who wants to communicate with her, asks for her Certificate. Bob, in order to verify her Certificate, finds the public key of the Certification Authority that signed the Alice's public key. He needs to do that securely. If they are both on the same Certification Authority then he has it already. If not, he asks his Certification Authority to contact the other Certification Authority for its public key. For each Certification Authority Bob's Certification Authority asks, he needs the public key of the previous one so that the authenticity of the key is assured. If a chain can be found that leads to the other Certification Authority then communication can be established. 

> Note: The issue of inter-CA trust is very important since one bad CA can undermine the security of the whole infrastructure. This issue is not covered here (at least in this version).
</details>

### 3.4. Genel anahtar şifrelemesinin tipik kullanımı
Gerçek anahtarları birbirine bağlayan kullanıcılar, güvenli bir şekilde iletişim kurabilir. Verileri şifreleyebilir ve dijital imza kullanabilirler. Şifreleme kısmı için, açık anahtar şifrelemesi çok miktarda verinin aktarımı için kullanılamaz. Simetrik bir şifre bu amaç için daha uygundur. Bu nedenle, simetrik şifre anahtarı, açık anahtar şifrelemesi kullanılarak şifrelenerek aktarılır.

<details>
3.4. Typical uses of public key cryptography
Having the authentic public keys of each other, users can communicate securely. They can encrypt data and make use of digital signatures. For the part of encryption, public key cryptography is too slow to be used for the transfer of large quantity of data. A symmetric cipher is more suited to this purpose. For this reason, the key for the symmetric cipher is transferred encrypted using public–key cryptography. 
</details>





## Bölüm 4. Genel uygulamaya genel bakış

Bir sertifika oluşturma ve bir Sertifika Yetkilisi çalıştırma süreçlerine teknik bir bakış sunuyoruz.

<details>
Chapter 4. General implementation overview

We give a technical overview of the processes of creating a certificate and operating a Certification Authority. 
</details>

### 4.1. Ön şartlar

Burada, kullanılabilir bir Sertifika Yetkilisi oluşturmak için gereken yazılımı tartışacağız.

#### 4.1.1. Yararlı açık kaynaklı yazılım

Aşağıdaki yazılım bir Sertifika Otoritesinin ortak işlevselliğini sağlayabilir.

* Sertifika Yetkilisi Sunucusu için herhangi bir işletim sistemi kullanılabilir. Kayıt Otoritesi ile manuel olarak iletişim kurması durumunda (örneğin, veri dosyaları bir disket kullanılarak aktarılır), ağ desteğinin olması gerekmez. Bununla birlikte, istikrarını güvence altına alan ve alakasız sistem veya ağ hizmetlerini kolayca kaldırılmış olabilecek işletim sistemleri kullanmak önerilir. Unix ™ veya Unix ™ benzeri işletim sistemlerini öneriyoruz.
* SSL / TLS yazılımı
* SSL / TLS desteği olan WWW sunucusu
* LDAP sunucusu
* Metin / Grafik Arayüzü, muhtemelen Java / HTML'de

> Not: PKIX standartları, bir CA / RA rolü için bir WWW sunucusunun kullanılmasını önermiyor veya yasaklamıyor. Hem CA hem de RA için bağımsız ağ uygulamaları oluşturma gereğini ortadan kaldırmak için, belirlenmiş Operatörler tarafından işletilen ayrı WWW sunucularını kullanmak mümkündür.

<details>
4.1. Prerequisites

We shall discuss here the software needed to create a usable Certification Authority. 

4.1.1. Useful open–source software

The following software can provide the collective functionality of a Certification Authority. 

* For the Certification Authority Server, any operating system can be used. In case it communicates manually with the Registration Authority (for example, data files are transfered using a floppy disk), it does not even need to have network support. However, it is recommended to use operating systems that provide some sort of assurance of its stability and can have irrelevant system or network services easily removed. We recommend Unix™ or Unix™–like operating systems. 
* SSL/TLS software
* WWW server with SSL/TLS support
* LDAP server
* Text/Graphical Interface, possibly in Java/HTML

> Note: The PKIX standards do not suggest nor forbid the use of a WWW server for the role of a CA/RA. To remove the need to create standalone network applications for both the CA and RA, it is possible to use individual WWW servers operated by designated Operators.

</details>

### 4.2. Sertifika Yetkilisinin Başlangıcı

Burada, CA'nın başlatma safhasını tanımlıyoruz. Bu bir kez gerçekleşir. CA'nın özel anahtarının korunması için özel bir dikkat gösterilmelidir.

> Not: Aşağıdaki örnekler, iş istasyonunuzda OpenSSL yazılımının yüklü olmasını gerektirir. Ayrıca, openssl uygulamasının bulunduğu dizininin PATH ortam değişkeninizde olması önerilir. Openssl uygulaması için olası yerler şunlardır: / usr / local / ssl / bin / veya / usr / bin /.

#### 4.2.1. CA için RSA anahtar çiftini oluşturun

RSA anahtar-çifti oluşturmak için bu komutu kullanın:

```
CA_Admin% openssl genrsa –des3 –out ca.key 2048
```

##### Parametreler

```
genrsa
 	 Bir RSA anahtar-çifti oluşturmak için openssl bileşeni,
-des3
 	 Anahtar-çifti şifrelemek için simetrik algoritma,
-out ca.key
 	 Anahtar çifti saklamak için dosya adı, 
2048
 	 RSA modülünün bit büyüklüğü.
```

Yukarıdaki komutu yerine getirirken, kullanıcıya aşağıdaki bilgiler verilir : 

```
1112 semi-random bytes loaded
Generating RSA private key, 2048 bit long modulus
.+++++
......................................................+++++
e is 65537 (0x10001)
Enter PEM pass phrase: enter the pass–phrase here
Verifying password - 
Enter PEM pass phrase: re–enter the pass–phrase here
```

Bu, ca.key dosyasında saklanan bir RSA anahtar çifti oluşturur. Bu anahtar çifti, anahtar üretimi sırasında kullanıcı tarafından sağlanan bir şifreyi kullanarak 3DES ile şifrelenir. RSA'daki N (iki asal sayının ürünü) 2048 bit uzunluğundadır. Kısalık açısından, 2048 bit RSA kullandığımızı söylüyoruz.

Parola ile şifrelenmiş örnek bir anahtar çifti Bölüm B.1'de bulunabilir. Parola ile şifrelenmemiş bu anahtar çifti Bölüm B.2'de verilmektedir. Aynı tuşun çözülmüş hali Bölüm B.3'te bulunabilir.

#### 4.2.2. Kendinden imzalı CA Sertifikası oluşturma

Kendinden imzalı bir CA Sertifikası almak için, CA'nın sertifika isteğini karşılık gelen özel anahtarla imzalamamız gerekir. Elde edilen Sertifika X.509 yapısına sahiptir.

```
CA_Admin% openssl req -new -x509-günler 365 -key ca.key -out ca.crt
```

##### Parametreler

```
req
 	 Bir sertifika isteği oluşturmak için openssl bileşeni,
-new
 	 Bu yeni bir sertifika,
-x509
 	 Bir X.509 sertifikası üretmek,
-days 365
 	 Sertifikanın geçerli olacağı gün sayısı, şu andan itibaren,
-key ca.key
 	 Kullanılacak anahtar çift dosyası,
-out ca.crt
 	 Yeni sertifikanın üzerine yazılacağı dosya adı
```

Yukarıdaki komutu yürütmek bu diyalogu sunar:

```
Using configuration from /usr/local/ssl/openssl.cnf
Enter PEM pass phrase:  enter the pass–phrase here
You are about to be asked to enter information that will be 
incorporated into your certificate request.
What you are about to enter is what is called a Distinguished 
Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:GB
State or Province Name (full name) [Some-State]:Surrey
Locality Name (eg, city) []:.
Organization Name (eg, company) [Internet Widgits Pty Ltd]: Best CA Ltd
Organizational Unit Name (eg, section) []:Class 1 Public Primary Certification Authority
Common Name (eg, YOUR name) []:Best CA Ltd
Email Address []:.
CA_Admin% 
```

Bu, ca.crt adlı kendinden imzalı bir sertifika oluşturur. Üretim tarihinden itibaren 365 gün geçerlidir. Bu adımda, CA Yöneticisi CA Kök Sertifikasının X.509 ayrıntılarını girmelidir.

PEM formatında bir örnek CA Sertifikası Bölüm B.4'te bulunabilir. Aynı Sertifikanın TXT veya insan tarafından okunabilir hali Bölüm B.5'te bulunabilir.

<details>
4.2. Initialisation of the Certification Authority
Here we describe the initialisation phase of the CA. This takes place once. Special care is needed for the protection of the CA's private key. 

> Note: The following examples require the OpenSSL software installed on your workstation. Also, it is recommended to have the directory that the openssl application resides, in your PATH environment variable. Possible locations for the openssl application are /usr/local/ssl/bin/ or /usr/bin/.

4.2.1. Generate the RSA key–pair for the CA
Use this command to generate the RSA key–pair: 

CA_Admin% openssl genrsa –des3 –out ca.key 2048

Parameters

```
genrsa
 	 the openssl component to generate an RSA key–pair, 
-des3
 	 the symmetric algorithm to encrypt the key–pair, 
-out ca.key
 	 the filename to store the key–pair, 
2048
 	 size of RSA modulus in bits. 
```

Executing the above command, the user is presented with the following information

```
1112 semi-random bytes loaded
Generating RSA private key, 2048 bit long modulus
.+++++
......................................................+++++
e is 65537 (0x10001)
Enter PEM pass phrase: enter the pass–phrase here
Verifying password - 
Enter PEM pass phrase: re–enter the pass–phrase here
```

This creates an RSA key pair which is stored in the file ca.key. This key pair is encrypted with 3DES using a password supplied by the user during key generation. The N in RSA (the product of the two prime numbers) is 2048 bits long. For brevity, we say that we use 2048-bit RSA. 

A sample key–pair, encrypted with a pass–phrase, can be found at Section B.1. This same key–pair without the pass–phrase encryption is at Section B.2. The decoded version of the same key can be found at Section B.3. 

4.2.2. Create a self–signed CA Certificate

In order to get a self–signed CA Certificate, we need to sign the CA's certificate request with the corresponding private key. The resulting Certificate has the X.509 structure. 

```
CA_Admin% openssl req –new –x509 –days 365 –key ca.key –out ca.crt
```

Parameters

```
req
 	 the openssl component to generate a certificate request, 
-new
 	 this is a new certificate, 
-x509
 	 generate an X.509 certificate, 
-days 365
 	 the time in days that the certificate will be valid, counting from now, 
-key ca.key
 	 the key–pair file to be used, 
-out ca.crt
 	 the filename that the new certificate will be written onto 
```

Executing the above command presents this dialogue: 

```
Using configuration from /usr/local/ssl/openssl.cnf
Enter PEM pass phrase:  enter the pass–phrase here
You are about to be asked to enter information that will be 
incorporated into your certificate request.
What you are about to enter is what is called a Distinguished 
Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:GB
State or Province Name (full name) [Some-State]:Surrey
Locality Name (eg, city) []:.
Organization Name (eg, company) [Internet Widgits Pty Ltd]: Best CA Ltd
Organizational Unit Name (eg, section) []:Class 1 Public Primary Certification Authority
Common Name (eg, YOUR name) []:Best CA Ltd
Email Address []:.
CA_Admin% 
```

This creates a self–signed certificate, called ca.crt. It is valid for 365 days from the date of generation. In this step, the CA Administrator has to enter the X.509 details of the CA Root Certificate. 

A sample CA Certificate, in PEM format, can be found at Section B.4. The TXT or human–readable of the same Certificate can be found at Section B.5. 
</details>

### 4.3. Kullanıcı / Sunucu anahtar üretimi ve imzalama
Kullanıcı, bu kullanıcı tarafından veya CA tarafından kimliği doğrulanması gereken herhangi bir varlık için kullanılacak bir sertifika için bir anahtar çifti üretir. İmzalama prosedürünü de gösteriyoruz.

#### 4.3.1. Bir kullanıcı / sunucu için RSA anahtar-çifti oluşturun
RSA anahtar çifti oluşturmak için bu komutu kullanın

```
User% openssl genrsa –des3 –out user.key 2048
```

##### Parametreler

```
genrsa
 	 Bir RSA anahtar-çifti oluşturmak için openssl bileşeni,
-des3
 	 Anahtar-çifti şifrelemek için simetrik algoritma,
-out user.key
 	 Anahtar çifti saklamak için dosya adı,
2048
 	 RSA modülünün bit büyüklüğü.
```

Yukarıdaki komutun uygulanması, kullanıcıya aşağıdaki diyalogu sunar:

```
1112 semi-random bytes loaded
Generating RSA private key, 2048 bit long modulus
.+++++
........................................................++++++++++++
e is 65537 (0x10001)
Enter PEM pass phrase: enter the pass–phrase here
Verifying password - Enter PEM pass phrase: re–enter pass–phrase here
```
Bu, user.key dosyasında saklanan bir RSA anahtar çifti oluşturur. Anahtar çifti, anahtar üretimi sırasında kullanıcı tarafından sağlanan bir şifre ile 3DES ile şifrelenir. RSA'daki N, 2048 bit uzunluğundadır.

Okuyucu, bunun CA anahtar çifti oluşturulmasıyla aynı prosedür olduğuna dikkat etmelidir. Örnek anahtar çiftleri için lütfen Bölüm 4.2.1'de listelenen ekleri inceleyin.

#### 4.3.2. Sertifika isteği oluştur

Kullanıcı, bu komutla bir sertifika isteği üretir. CSR imzalamak için CA'ya gönderilir. CA imzalanmış sertifikayı geri gönderir.

```
User% openssl req –new –key user.key –out user.csr
```
 
##### Parametreler

```
req
 	 Bir sertifika isteği oluşturmak için openssl bileşeni,
-new
 	 Bu yeni bir sertifika,
-key user.key
 	 Kullanılacak anahtar çift dosyası,
-out user.csr
 	 Yeni sertifika isteğinin üzerine yazılacağı dosya adı
```

Yukarıdaki komutu uygulayarak, aşağıdaki diyalog sunulmaktadır:

```
Using configuration from /usr/local/ssl/openssl.cnf
Enter PEM pass phrase:  type the pass–phrase here
You are about to be asked to enter information that will 
be incorporated into your certificate request.
What you are about to enter is what is called a 
Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:GB
State or Province Name (full name) [Some-State]:Surrey
Locality Name (eg, city) []:Egham
Organization Name (eg, company) [MyCo Ltd]:Arts Building Ltd
Organizational Unit Name (eg, section) []:Dept. History
Common Name (eg, YOUR name) []:Simos Xenitellis
Email Address []:S.Xenitellis@rhbnc.ac.uk

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:.
An optional company name []:.
User% 
```

Bu komut, user.csr dosyasında saklanan bir sertifika isteği oluşturur. Bu aşamada, kullanıcı gösterildiği gibi X.509 Sertifikası alanlarının değerlerini girer. PEM formatında bir sertifika isteği için Bölüm B.6'ya bakınız. Bir TXT veya insan tarafından okunabilen sürüm için lütfen Bölüm B.7'yi kontrol edin.

#### 4.3.3. CA'dan sertifika isteğini imzalamasını isteyin

CA sertifika talebini alır ve kullanılan ilkeye bağlı olarak CSR'yi imzalamaya karar verip vermeyeceğine karar verir. Kullanıcıya güveniyorsa, CSR'yi şu şekilde imzalar:

```
CA_Admin% ./sign.sh user.csr
CA signing: user.csr -> user.crt:
Using configuration from ca.config
Enter PEM pass phrase: enter the pass–phrase
Check that the request matches the signature
Signature ok
The Subjects Distinguished Name is as follows
countryName           :PRINTABLE:'GB'
stateOrProvinceName   :PRINTABLE:'Surrey'
localityName          :PRINTABLE:'Egham'
organizationName      :PRINTABLE:'Arts Building Ltd'
organizationalUnitName:PRINTABLE:'Dept. History'
commonName            :PRINTABLE:'Simos Xenitellis'
emailAddress          :IA5STRING:'S.Xenitellis@rhbnc.ac.uk'
Certificate is to be certified until Feb  6 13:30:41 2001 GMT (365 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
CA verifying: user.crt <-> CA cert
user.crt: OK
CA_Admin% 
```

Bu komut, kullanıcı sertifikası olan user.crt adlı bir dosya oluşturur. Sign.sh betiği, yukarıda açıklanan ve / pkg.contrib / dizininde bulunan modssl paketinde bulunabilir. Bu komut, openssl'yi bir arka plan olarak kullanıyor. Komut dosyasını kullanıyoruz ve manuel prosedürü değil, ikinci prosedür ile birkaç adım daha gerçekleştirmek zorunda kalacağız ve bu da bu kitabın kapsamı dışına çıkacaktı. Bu belgenin gelecekteki bir versiyonunda, bu sayıyı tekrar gözden geçireceğiz.

<details>
### 4.3. User/Server key generation and signing
The user generates a key pair for a certificate to be used by that user or any entity that needs to be authenticated by the CA. We also show the signing procedure. 

#### 4.3.1. Generate the RSA key–pair for a user/server
Use this command to generate the RSA key pair

```
User% openssl genrsa –des3 –out user.key 2048
```

Parameters

```
genrsa
 	 the openssl component to generate an RSA key–pair, 
-des3
 	 the symmetric algorithm to encrypt the key–pair, 
-out user.key
 	 the filename to store the key–pair, 
2048
 	 size of RSA modulus in bits. 
```

Execution of the above command presents the user with the following dialogue: 

```
1112 semi-random bytes loaded
Generating RSA private key, 2048 bit long modulus
.+++++
........................................................++++++++++++
e is 65537 (0x10001)
Enter PEM pass phrase: enter the pass–phrase here
Verifying password - Enter PEM pass phrase: re–enter pass–phrase here
```

This creates an RSA key pair stored in the file user.key. The key pair is encrypted with 3DES with a password supplied by the user during key generation. The N in RSA is 2048 bits long. 

The reader should note that this is the same procedure as the generation of the CA key–pair. For sample key–pairs, please see the appendices listed in Section 4.2.1. 

#### 4.3.2. Generate a certificate request

The user generates a certificate request with this command. The CSR is sent to the CA for signing. The CA returns the the signed certificate. 

```
User% openssl req –new –key user.key –out user.csr
```
##### Parameters
```
req
 	 the openssl component to generate a certificate request, 
-new
 	 this is a new certificate, 
-key user.key
 	 the key–pair file to be used, 
-out user.csr
 	 the filename that the new certificate request will be written onto 
```

By executing the above command, we are presented with the following dialogue:

```
Using configuration from /usr/local/ssl/openssl.cnf
Enter PEM pass phrase:  type the pass–phrase here
You are about to be asked to enter information that will 
be incorporated into your certificate request.
What you are about to enter is what is called a 
Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:GB
State or Province Name (full name) [Some-State]:Surrey
Locality Name (eg, city) []:Egham
Organization Name (eg, company) [MyCo Ltd]:Arts Building Ltd
Organizational Unit Name (eg, section) []:Dept. History
Common Name (eg, YOUR name) []:Simos Xenitellis
Email Address []:S.Xenitellis@rhbnc.ac.uk

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:.
An optional company name []:.
User% 
```

This command creates a certificate request stored in the file user.csr. In this phase, the user enters the values of the fields for the X.509 Certificate as shown. For a certificate request in PEM format, please see Section B.6. For a TXT or human–readable version, please check Section B.7. 

#### 4.3.3. Ask the CA to sign the certificate request

The CA receives the certificate request, and depending on the policy used, will decide whether to sign the CSR. If it trusts the user, it signs the CSR as follows: 

```
CA_Admin% ./sign.sh user.csr
CA signing: user.csr -> user.crt:
Using configuration from ca.config
Enter PEM pass phrase: enter the pass–phrase
Check that the request matches the signature
Signature ok
The Subjects Distinguished Name is as follows
countryName           :PRINTABLE:'GB'
stateOrProvinceName   :PRINTABLE:'Surrey'
localityName          :PRINTABLE:'Egham'
organizationName      :PRINTABLE:'Arts Building Ltd'
organizationalUnitName:PRINTABLE:'Dept. History'
commonName            :PRINTABLE:'Simos Xenitellis'
emailAddress          :IA5STRING:'S.Xenitellis@rhbnc.ac.uk'
Certificate is to be certified until Feb  6 13:30:41 2001 GMT (365 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
CA verifying: user.crt <-> CA cert
user.crt: OK
CA_Admin% 
```

This command produces a file called user.crt, the Certificate of the user. The sign.sh script can be found in the modssl package, described above, at the /pkg.contrib/ directory. This script uses openssl as a backend. We use the script and not the manual procedure because with the latter we would have to perform rather several steps and this would be out of the scope of this book. In a future version of this document, we shall revisit this issue. 

</details>


## Bölüm 5. PKI standartları ve özellikleri

Mevcut PKI ile ilgili standartları ve spesifikasyonları tanımlıyor ve her birinin kullanılabilirliğini tartışıyoruz. Açık kaynak kodlu PKI'ler için açık standartlar ve özellikler açık kaynaklı uygulamaların olası birlikte çalışabilirlik engellerini ortadan kaldırdığı için önemlidir.

<details>
## Chapter 5. PKI standards and specifications

We describe available PKI-related standards and specifications and discuss the usability of each of them. Open standards and specifications are important to open–source PKIs, since they remove possible interoperability obstacles of closed–source implementations. 

</details>


### 5.1. Internet X.509 Açık Anahtar Altyapısı (PKIX)

PKIX, Bölüm 6'da ele alınmıştır.

<details>
### 5.1. Internet X.509 Public Key Infrastructure (PKIX)

PKIX is covered in Chapter 6. 
</details>

### 5.2. Açık Anahtar Altyapısı İçin Mimari (APKI)

APKI, The Open Group (http://www.opengroup.org) tarafından oluşturulan bir Ortak Anahtar Altyapısı için bir şarttır. Bir PKI mimarisini, gereksinimlerini ve bileşenlerini açıklar. Ayrıca, uygulayıcılar için protokollerin kullanımı ve diğer spesifikasyonlar hakkında tavsiyeler verir. Bu belirtim (http://www.opengroup.org/pubs/catalog/g801.htm) HTML ve PDF formatında mevcuttur ve bir WWW sitesinde özgürce kayıt yaptırarak indirebilirsiniz. Bir basılı kopya da mevcuttur.

Özetle, bu belirtim, bir PKI bileşenleri hakkında üst düzey bir bakış sunar ve standart tabanlı bir işlevsellik elde etmek için kullanılması gereken diğer protokolleri ve belirtimleri önermektedir. Özetlemek gerekirse,

* PKIX standartları, Bölüm 6 kapsamında.
* CDSA 2.0 Ortak Veri Güvenliği Mimarisi, Bölüm 9.7'de ele alınmıştır.
XDAS Dağıtımlı Denetim Hizmeti, Bölüm 9.10'da kapsanmıştır.
* GSS-API Genel Güvenlik API'sı ve onun uzantıları (XGSS-API), Bölüm 9.11'de ele alınmıştır.
* Bölüm 9.13'te ele alınan LDAP Hafif Dizin Erişimi Protokolü.
* IETF S / MIME Şifreleme Mesaj Sözdizimi (CMS), sürüm 3, Bölüm 9.14'te ele alınmıştır.
* Bölüm 9.12'de ele alınan IETF (RFC2030) Basit Ağ Zaman Protokolü (SNTP).

<details>
### 5.2. Architecture for Public-Key Infrastructure (APKI)

APKI is a specification for a Public Key Infrastructure, created by the The Open Group (http://www.opengroup.org). It describes the architecture, the requirements and the components of a PKI. Also, it gives recommendations for implementors on the use of protocols and other specifications. This specification (http://www.opengroup.org/pubs/catalog/g801.htm) is available in HTML and PDF format and one can download it by registering freely on the WWW site. A hard copy is also available. 

In a nutshell, this specification gives a high-level overview of the components of a PKI and recommends other protocols and specifications that should be used in order to get a standard-based functionality. Summing up, it recommends the use of 

* The PKIX standards, covered in Chapter 6. 
* The CDSA 2.0 Common Data Security Architecture, covered in Section 9.7. 
* The XDAS Distributed Audit Service, covered in Section 9.10. 
* The GSS-API Generic Security API and its extensions (XGSS-API), covered in Section 9.11. 
* The LDAP Lightweight Directory Access Protocol, covered in Section 9.13. 
* The IETF S/MIME Cryptographic Message Syntax (CMS), version 3, covered in Section 9.14. 
* The IETF (RFC2030) Simple Network Time Protocol (SNTP), covered in Section 9.12. 
</details>

### 5.3. NIST Açık Anahtar Altyapısı Programı

ABD Ticaret ve Sanayi Odası'nın bir parçası olan Ulusal Standartlar ve Teknoloji Enstitüsü (NIST), ABD devlet elektronik altyapısının dahili kullanımı için Genel Anahtar Altyapıları için spesifikasyonlar geliştiriyor. Bu çabalar, genel anahtar teknolojisinin muhtemelen çalışamayan uygulamalardan kullanımını kolaylaştırmaktan ziyade mevcut PKI tedarikçilerinin çoğaltılmasını amaçlamaz.

Bu çalışma, şirketlerin ve hükümetin ürettikleri PKI ürünlerini bir tüketici olarak satın alacaklarını belirtmek için birlikte çalıştıkları anlamda CRADAs (Kooperatif Araştırma ve Geliştirme Anlaşmaları) adlı anlaşmaları kullanan endüstri ortakları yardımıyla geliştirilmektedir. Bu anlamda, ABD hükümeti büyük bir alıcı olduğu için, NIST'in çalışmalarının dünya çapında kullanılacak PKI ürünlerinin geleceğini belirten bir şekilde olmasını bekleyebilirsiniz.

Herkese açık belgeler arasında farklı satıcılardan gelen PKI bileşenleri arasında iş birliği için bir temel oluşturan MISPC spesifikasyonu bulunmaktadır. ABD Federal kuruluşları için sözleşme imzalamak isteyen satıcı, uyumlu PKI bileşenleri sağlamalıdır. Olası açık kaynaklı PKI uygulamaları açıkça bu spesifikasyonlara uymak zorundadır. MISPC spesifikasyonu ayrıca Bölüm 7.6'da açıklanan NIST referans uygulamasının temelidir. NIST WWW sitesinden NIST Özel Yayın 800-15 (http://csrc.nist.gov/pki/documents/mispcv1.ps) olarak edinilebilir.

Bir başka ilginç belge, Önerilen Federal PKI Çalışma Kavramı'dır (http://csrc.nist.gov/pki/twg/baseline/pkicon20b.PDF).

Yukarıdaki belgenin en önemli noktalarından biri, mevcut PKI türlerinin açık bir şekilde tanımlanmasıdır. Tarayıcıların uyguladığı PKI, güven listesinde PKI olarak tanımlanmaktadır. Bu, yalnızca bir düzeyde güven olduğu anlamıyla düz bir PKI türüdür. Diğer iki tür hiyerarşik ve ağ (veya örgü) PKI'lerdir. Birincisi tipik X.500 PKI iken, ikincisi tek bir köke sahip olmayan örgü türüdür. Hiyerarşik PKI'ların benzerliklerini Alan Adı Servisi yapısı ile bulabiliriz. PKI ağı internet üzerindeki yönlendiricilerin arabağlantıları gibidir.

Bir diğer önemli konu da aynı belgedir, köprü Sertifika Yetkilisi konsepti, farklı güven alanlarını köprüleyen bir CA'nın kullanılmasıdır. Bu köprüleme, ilgili tarafların mutabakata varması üzerine kurulmuştur ve amacı, gereksiz güvenin yayılmasını sınırlamaktır.

Köprü CA kavramını test etmek için bir pilot program planlanmaktadır. Köprü CA'sı, NIST PKI Kök CA Test Merkezi'nde (http://csrc.nist.gov/pki/rootca/) verilen bilgilerden NIST tarafından uygulanacak ve ticari CA'ler bu Köprü ile köprülenerek test edilecektir CA. Plan, oniki CA'yı ve 4 X.509 Dizin sunucusu operasyonel olarak çalıştırmaktır. Bu pilot operasyondan aranacak bilgiler, performans ve ölçeklenebilirlik ile ilgilidir. Son olarak, X.509 sertifikasyon yolu oluşturma ve doğrulama test edilecektir.

Bu belgelerin yazarı (ana yazar ya da işbirliği içinde) William E. Burr'dır (mailto: william.burr@nist.gov).

<details>

### 5.3. The NIST Public Key Infrastructure Program

The National Institute of Standards and Technology (NIST), part of the U.S. Department of Commerce, is developing specifications for Public Key Infrastructures for the internal use of the U.S. government electronic infrastructure. These efforts do not aim to duplicate existing work of PKI vendors, rather than to ease the integration of the use of public-key technology from possibly inoperable implementations. 

This work is being developed with the help of industry partners, using agreements called CRADAs (Cooperative Research and Development Agreements) in the sense that companies and the government work together to specify the PKI products to be produced that the latter will buy as a consumer. In this sense, since the U.S. government is a big buyer, one can expect that the work of the NIST somehow specifies the future of the PKI products that will be used worldwide. 

Among the publicly available documents is the MISPC specification that provides a basis for interoperation between PKI components from different vendors. Vendor willing to get contracts for U.S. Federal agencies should be able to provide compatible PKI components. Possible open-source PKI implementations would obviously need to comply with those specifications. The MISPC specification is the basis for the NIST reference implementation, also described in Section 7.6. It is available as NIST Special Publication 800-15 (http://csrc.nist.gov/pki/documents/mispcv1.ps) from the NIST WWW site. 

Another interesting document is the Proposed Federal PKI Concept of Operation (http://csrc.nist.gov/pki/twg/baseline/pkicon20b.PDF). 

Among the highlights of the above document is the clear description of available PKI types. The PKI that the browsers implement is described as the trust-list PKI. This is a somehow flat type of PKI in the sense that there is only one level of trust. The other two types are the hierarchical and the network (or mesh) PKIs. The former is the typical X.500 PKI while the latter is the mesh type with no single root. One can find analogies of the hierarchical PKI with the structure of the Domain Name Service. The network PKI is like the interconnection of the routers on the Internet. 

Another important issue is the same document, is the use the Bridge Certification Authority concept, a CA that bridges different trust domains. This bridging is established upon agreement of the interested parties and its purpose is to limit the propagation of unnecessary trust. 

A pilot program is planned to test the bridge CA concept. From the information provided at the NIST PKI Root CA Testbed (http://csrc.nist.gov/pki/rootca/) page, the Bridge CA will be implemented by the NIST and commercial CAs will be tested by being bridged by this Bridge CA. The plan is to have twelve CAs and 4 X.509 Directory servers operational. Information to be sought from this pilot operation has to do with performance and scalability. Finally, the X.509 certification path building and validation will be tested. 

The author of these documents (either main author or in co-operation) is William E. Burr (mailto:william.burr@nist.gov). 
</details>









## Bölüm 6. İnternet X.509 Açık Anahtar Altyapısı (PKIX)

Bu bölümde, PKIX Çalışma Grubu (http://www.ietf.org/html.charters/pkix-charter.html) tarafından geliştirilen PKIX İnternet Standartlarına gayri resmi bir giriş yapacağız.

<details>
## Chapter 6. Internet X.509 Public Key Infrastructure (PKIX)

In this chapter, we shall provide an informal introduction to the PKIX Internet Standards which are being developed by the PKIX Working Group (http://www.ietf.org/html.charters/pkix-charter.html). 
</details>

### 6.1. Kısaltmalar

PKIX terminolojisiyle ilgili karışıklığı önlemek için, terimlerin listesini, PKIX belge taslak-ietf-pkix-yol haritası-05'de bulunan gibi ekledik. Onların tam açıklaması Glossary'de bulunabilir.

#### Tablo 6-1. PKIX Terimleri

X.509 terimiyle ilgili olarak, dizin hizmetleri hakkındaki X.500 belirtiminden gelir. Dizin hizmetleri, etkinleştirilmiş uygulamaların kapsanan varlıkları arayabileceği bir tür elektronik telefon rehberi olarak işlev görür. Her varlık tanımlayıcı bir kayıt veya Sertifikaya sahiptir ve bu Sertifikanın biçimi Uluslararası Telekomünikasyon Birliği (ITU) X.509'un önerisini izler.

X.500'ün kendisini yakalaması çok zor kabul edilir, ancak sertifikalar için X.509 biçimi başarılı standartlar tarafından kullanılır. X.500 hakkında daha fazla bilgi için, D.W.Chadwick tarafından hazırlanmış X.500 - Dizin Öğrenme kitabının (http://www.salford.ac.uk/its024/X500.htm) çevrimiçi kitabını okuyabilirsiniz.

<details>
### 6.1. Abbreviations

To avoid confusion regarding the PKIX terminology, we include the list of terms as they are found in the PKIX document draft-ietf-pkix-roadmap-05. Their full explanation can be found at the Glossary. 

#### Table 6-1. PKIX Terms

With regard to the term X.509, it comes from the X.500 specification on directory services. The directory services serve as a kind of electronic phonebook, where enabled applications can lookup included entities. Each entity has a identifying record or Certificate and the format of that Certificate follows the recommendation X.509 of the International Telecommunication Union (ITU). 

X.500 itself is considered as too difficult to catch on, however, the X.509 format for certificates is used by succesive standards. For more information on X.500, one can read the online book entitiled Understanding X.500 – The Directory (http://www.salford.ac.uk/its024/X500.htm) by D.W.Chadwick. 
</details>

### 6.2. Kavramlar

PKIX standartlarıyla ilgili önemli kavramları açıklıyoruz. Bir Kamu Altyapısı, yalnızca kimlikleri idare edecek bir altyapıya ihtiyaç duymaz, ayrıcalıkları ele alacak bir altyapıya ihtiyaç duyar. İkisi arasındaki ayrım aşağıdaki bölümlerde daha belirgin hale gelecektir.

<details>
### 6.2. Concepts

We describe important concepts with regard to the PKIX standards. A Public Key Infrastructure does not only need an infrastructure to handle identities, it needs an infrastructure to handle privileges. The distinction between the two will become more evident in the following sections. 

</details>

#### 6.2.1. Sertifika Kullanan Sistemler ve PKI'ler

Internet güvenliğini artırmak için yapılan son çabaların merkezinde, Güvenli Çok Amaçlı Internet Posta Uzantıları (S / MIME), Aktarım Katmanı Güvenliği (TLS) ve Internet Protokol Güvenliği (IPSec) gibi bir güvenlik protokolleri grubu bulunmaktadır. Bu protokollerin tümü gizlilik, veri bütünlüğü, veri kökenli kimlik doğrulama ve reddetme gibi hizmetleri sağlamak için açık anahtar şifrelemesine dayanmaktadır. Bir PKI'nın amacı, güvenilir, verimli anahtar ve açık anahtar sertifikası yönetimi sağlamak ve böylece kimlik doğrulama, reddedilme ve gizlilik kullanımını sağlamaktır.

> #Güvenlik hizmetleri

> İnternetteki güvenliği sağlamak için gereken temel hizmetler, gizlilik, veri bütünlüğü, veri kökenli kimlik doğrulama ve reddedilme olmaktır. Bunlar S / MIME, TLS ve IPSec gibi protokollerle sağlanabilir. Protokollerin etkili bir şekilde çalışması için bir PKI'ye ihtiyaç vardır.

Açık anahtar temelli sistem kullanıcıları, ortak bir anahtara güvenirse, ilişkili özel anahtara, iletişim kurduğu konunun mülkiyetindedirler. (Bu, bir şifreleme veya dijital imza mekanizmasının kullanılıp kullanılmadığı için geçerlidir.) Bu güven, kamu anahtarı değerlerini konularda bağlayan veri yapıları olan PKC'lerin kullanımı yoluyla elde edilir. Bağlama, kişinin kimliğini doğrulamak ve her PKC'yi dijital olarak imzalamak için güvenilir bir CA'ya sahip olmak suretiyle sağlanır.
 
PKC'nin imzalanmış içeriğinde belirtilen sınırlı bir geçerli ömrü vardır. Bir PKC imzası ve güncelliği, bir sertifika-kullanan istemci tarafından bağımsız olarak kontrol edilebildiğinden, PKC'ler güvenilmeyen iletişim ve sunucu sistemleri vasıtasıyla dağıtılabilir ve sertifika kullanan sistemlerde güvensiz depoda önbelleğe alınabilir.
 
PKC'ler imzalanmış verileri doğrulama sürecinde kullanılır. Hangi algoritmanın kullanıldığına göre özellikler değişir, ancak genel işlem aşağıdaki gibi iş görür:
Not: Aşağıda listelenen çeklerin yapılabilmesi için belirli bir emir yoktur; Uygulayıcılar sistemleri için en verimli şekilde uygulamakta serbesttirler.
 
* İmzalanan verilerin alıcısı, kullanıcının kimliğinin PKC'deki kimlikle uyumlu olduğunu doğrular;
* Alıcı, yolda hiçbir PKC'nin iptal edilmediğini doğrular (örneğin uygun bir şekilde geçerli olan Sertifika İptal Listesinin (CRL) alınması veya bir çevrimiçi sertifika durumunun sorulması sorulması suretiyle) ve tüm PKC'ler o tarihteki geçerlilik süreleri içindedir Veriler imzalanmıştır;
* Alıcı, verilerin, PKC'nin imzalayan kişinin yetkili olmadığını belirten değerlere sahip olduğu iddia edilmediğini doğrular;
* Alıcı imzalandıktan sonra, PKC'deki genel anahtarı kullanarak verilerin değiştirilmediğini doğrular.
 
Bu kontrollerin hepsi geçerse alıcı, verinin sözde imzalayan tarafından imzalanmış olduğunu kabul edebilir. Şifreleme için kullanılan tuşların işlemi benzerdir.

> Not: Tabii ki verilerin, imzalayan kişinin özel anahtarı tehlikeye girdiğinde, imzalayan kişiden çok farklı birisi tarafından imzalanmış olması mümkündür. Güvenlik, sertifika kullanma sistemi sisteminin tüm bölümlerine bağlıdır; bunlarla sınırlı olmamak üzere şunlar: bilgisayarın bulunduğu yerde fiziksel güvenlik; Personel güvenliği (yani sistemi geliştiren, kuran, çalıştıran ve bakım yapan kişilerin güvenilirliği); Özel anahtarın kullanıldığı işletim sistemi tarafından sağlanan güvenlik; Ve güvenlik CA'yı sağladı. Bu alanlardan herhangi birindeki bir arıza, tüm sistem güvenliğinin başarısız olmasına neden olabilir. Bununla birlikte, PKIX kapsamı sınırlıdır ve yalnızca doğrudan PKI alt sisteminin çalışmasıyla ilgili konuları ele almaktadır. Diğer alanların çoğunda rehber olmak için RFC 2527'ye bakın.

<details>
#### 6.2.1. Certificate–using Systems and PKIs

At the heart of recent efforts to improve Internet security are a group of security protocols such as Secure Multipurpose Internet Mail Extensions (S/MIME), Transport Layer Security (TLS), and Internet Protocol Security (IPSec). All of these protocols rely on public–key cryptography to provide services such as confidentiality, data integrity, data origin authentication, and non-repudiation. The purpose of a PKI is to provide trusted and efficient key and public key certificate management, thus enabling the use of authentication, non-repudiation, and confidentiality. 

> #Security services

> Essential services to ensure the security on the Internet are confidentiality, data integrity, data origin authentication and non–repudiation. These can be achieved with protocols like S/MIME, TLS and IPSec . The protocols need a PKI in order to function effectively. 

Users of public key-based systems must be confident that, any time they rely on a public key, the associated private key is owned by the subject with which they are communicating. (This applies whether an encryption or digital signature mechanism is used.) This confidence is obtained through the use of PKCs, which are data structures that bind public key values to subjects. The binding is achieved by having a trusted CA verify the subject's identity and digitally sign each PKC. 
 
A PKC has a limited valid lifetime, which is indicated in its signed contents. Because a PKC's signature and timeliness can be independently checked by a certificate-using client, PKCs can be distributed via untrusted communications and server systems, and can be cached in unsecured storage in certificate-using systems.
 
PKCs are used in the process of validating signed data. Specifics vary according to which algorithm is used, but the general process works as follows: 
Note: There is no specific order in which the checks listed below must be made; implementors are free to implement them in the most efficient way for their systems.
 
* The recipient of signed data verifies that the claimed identity of the user is in accordance with the identity contained in the PKC; 
* The recipient validates that no PKC in the path is revoked (e.g., by retrieving a suitably-current Certificate Revocation List (CRL) or querying an on-line certificate status responder), and that all PKCs are within their validity periods at the time the data was signed; 
* The recipient verifies that the data are not claimed to have any values for which the PKC indicates that the signer is not authorized; 
* The recipient verifies that the data have not been altered since signing, by using the public key in the PKC. 
 
If all of these checks pass, the recipient can accept that the data was signed by the purported signer. The process for keys used for encryption is similar. 

> Note: It is of course possible that the data was signed by someone very different from the signer, if for example the purported signer's private key was compromised. Security depends on all parts of the certificate-using system, including but not limited to: physical security of the place the computer resides; personnel security (i.e., the trustworthiness of the people who actually develop, install, run, and maintain the system); the security provided by the operating system on which the private key is used; and the security provided the CA. A failure in any one of these areas can cause the entire system security to fail. PKIX is limited in scope, however, and only directly addresses issues related to the operation of the PKI subsystem. For guidance in many of the other areas, see RFC 2527.
</details>

#### 6.2.2. Sertifika Kullanan Sistemler ve PMI'ler

Birçok sistem, kimlik tabanlı erişim kontrol kararlarını uygulamak için PKC'yi kullanmaktadır (diğer bir deyişle, kimlik, kimlik doğrulama tabanlı erişim kontrolü kararlarını desteklemek için kullanılabilmektedir; müşteri, PKC'de bulunan ortak anahtara karşılık gelen özel anahtara erişimi olduğunu kanıtladığında) ). Pek çok sistem için bu yeterli, ancak giderek artan bir şekilde, kural tabanlı, rol tabanlı ve sıraya dayalı erişim denetiminin gerekli olduğunu bulmaya başlıyor. Erişim kontrolü kararlarının bu biçimleri, PKC'ye normalde dahil edilmeyen ek bilgi gerektirir, çünkü bilgilerin ömrü, genel-özel anahtar çifti ömründen çok daha kısadır. Bu bilgiyi PKC'ye bağlamayı desteklemek için, ANSI'de tanımlanan ve daha sonra ITU-T Recommendation X.509'da yer alan Öznitelik Sertifikası (AC). AC biçimi, dijital olarak imzalanmış bir veri yapısında bir PKC'ye ya da birden fazla PKC'de aynı kimliği olduğunda yararlı olan birden çok PKC'ye bir referans ekleyerek herhangi bir ek bilginin bir PKC'ye bağlanmasına izin verir. Ayrıca, AC, yalnızca bir veya daha fazla belirli hedeflerde (örneğin, web sunucusu, posta barındırma aracı) faydalı olacak şekilde oluşturulabilir.

Bir PMI kullanıcısı, bir niteliği temsil eden kimliğin bu niteliğe sahip olma hakkına sahip olduğuna emin olmalıdır. Bu güven PKC'lerin kullanımı yoluyla elde edilebilir veya AC kullanan sistemde yapılandırılabilir. PKC'ler kullanılırsa, erişim denetimi kararını veren parti "AC yayınlayan bu nitelikteki AC'leri yayınlamaya güvendiğinde" karar verebilir.

<details>
#### 6.2.2. Certificate–using Systems and PMIs

Many systems use the PKC to perform identity based access control decisions (i.e., the identity may be used to support identity-based access control decisions after the client proves that it has access to the private key that corresponds to the public key contained in the PKC). For many systems this is sufficient, but increasingly systems are beginning to find that rule-based, role-based, and rank- based access control is required. These forms of access control decisions require additional information that is normally not included in a PKC, because the lifetime of the information is much shorter than the lifetime of the public-private key pair. To support binding this information to a PKC the Attribute Certificate (AC) was defined in ANSI and later incorporated into ITU–T Recommendation X.509. The AC format allows any additional information to be bound to a PKC by including, in a digitally signed data structure, a reference back to one specific PKC or to multiple PKCs, useful when the subject has the same identity in multiple PKCs. Additionally, the AC can be constructed in such a way that it is only useful at one or more particular targets (e.g., web server, mail host). 

Users of a PMI must be confident that the identity purporting to posess an attribute has the right to possess that attribute. This confidence may be obtained through the use of PKCs or it may be configured in the AC-using system. If PKCs are used the party making the access control decision can determine "if the AC issuer is trusted to issue ACs containing this attribute." 
</details>

### 6.3. PKIX yaklaşımına genel bakış

PKIX, açık anahtar altyapılarını tanımlamak için PKI ve PMI terimlerini kullanır. İkisi arasında benzerlikler bulunur. Ana fark, PMI Öznitelik Sertifikalarını işlerken PKI'nin Açık Anahtar Sertifikalarını ele almasıdır. İkisini birbirinden ayırmak için iyi bir metafor, bir kişinin pasaportuyla, diğerinin ise vizeyle ilişkilendirilmesidir. Kimse kimlik ve diğer izni verir.

<details>
### 6.3. Overview of the PKIX approach

PKIX, in order to describe public–key infrastructures, uses the terms PKI and PMI. One can find similarities between the two. The main difference is that the PKI handles the Public Key Certificates while the PMI handles the Attribute Certificates. A good metaphor to distinguish between the two is to associate the former with the passport of a person and the latter with the visa. The one provides identity and the other permission. 
</details>

#### 6.3.1. PKIX standartlaştırma alanları

PKIX aşağıdaki beş alanda çalışıyor.

1. X.509 v3 Açık Anahtar Sertifikalarının ve X.509 v2 Sertifika İptal Listelerinin (CRL) profilleri.

Temel sertifika alanlarını ve Sertifikalar ve Sertifika İptal Listeleri için desteklenecek uzantıları açıklar. Ardından, temel ve genişletilmiş Sertifika Yolu Doğrulaması hakkında konuşur. Sonunda, desteklenen kriptografik algoritmaları kapsar.

2. Yönetim protokolleri.

İlk olarak, protokollerin varsayımlarını ve kısıtlamalarını tartışır. Ardından PKI yönetim iletileri için kullanılan veri yapılarını sağlar ve uygulamalara uyan işlevleri tanımlar. Son olarak, PKI iletilerini taşımak için basit bir protokol açıklanmaktadır.

3. Operasyonel protokoller.

Şu anda, LDAPv2, FTP ve HTTP'in işlem protokolleri olarak nasıl kullanılabileceğini açıklıyorlar.

4. Sertifika politikaları ve Sertifika Uygulama Tabloları.

Bu belgenin amacı, sertifika politikaları ile CPS'ler arasında açık bir ilişki kurmak ve sertifika politikaları ya da CPS'lerin yazarlarına görevleriyle yardımcı olmak için bir çerçeve sunmaktır. Özellikle, çerçeve, bir sertifika ilkesinin veya bir CPS'nin formüle edilmesinde dikkate alınması gereken unsurları tanımlar. Amaç, belirli sertifika politikalarını veya CPS'leri tek tek tanımlamak değildir.

5. Zaman damgası ve veri belgelendirme / doğrulama hizmetleri.

Belgeler hala İnternet Taslakları olarak sınıflandırıldığından, bu hizmetlerde henüz RFC bulunmamaktadır.

Zaman damgası hizmeti, bir datumun belirli bir noktada bulunduğunu belirtmek için zaman etiketi belirteçleri oluşturan güvenilir bir üçüncü taraf tanımlar. Veri belgeleme ve doğrulama hizmetleri, veri bulundurma ve veri bulundurma iddiasını ve dijital olarak imzalanmış belgelerin ve sertifikaların geçerliliğini belgelemektedir.
 
İlgili RFC belgeleri aşağıdaki tabloda gösterilmiştir.

#### Tablo 6-2. PKIX belgelerinin RFC'leri tablosu

X.509 Sertifikalarının belirtimi çok geneldir ve genişletilebilir. Farklı internet merkezli uygulamalar arasında birlikte çalışabilirliği sağlamak için

PKIX Çalışma Grubu, Internet PKI'si için sertifika ve sertifika iptal listelerinin biçim ve anlambiliminin bir açıklaması olan bir profili tanımladı.

İşlevsel protokoller, sertifikaları ve istemci sistemlerini kullanarak CRL'leri (veya durum bilgilerini) iletmek için gereken protokollerdir. Sertifikalar ve CRL'ler için, örneğin LDAP, HTTP ve FTP'yi kullanarak çeşitli dağıtım mekanizmalarına sahip olmaya vurgu yapılır. Örneğin, bir sertifikanın geçerli olup olmadığını kontrol etmek için bir satıcı tarafından CRL'nin alınması, bir operasyonel protokol oluşturmaktadır.

Yönetim protokolleri PKI kullanıcı ve yönetim birimleri arasındaki çevrimiçi etkileşimleri desteklemek için gereken protokollerdir. Yönetim protokolleri tarafından desteklenebilecek olası fonksiyon seti şu şekildedir:

* Sertifikanın düzenlenmesinden önce gerçekleşen varlığın kaydı
* Başlatma, örneğin anahtar çiftinin oluşturulması
* Belgelendirme, sertifikanın verilmesi
* Anahtar çift kurtarma, kayıp anahtarları kurtarma yeteneği
* Sertifika süresi dolduğunda ve yeni bir anahtar çifti ve sertifikanın üretilmesi gereken anahtar çift güncelleme
* Yetkili bir kişi, CA'yı iptal listesine belirli bir sertifika eklemek üzere önerdiğinde iptal talebi
* Çapraz sertifika, iki CA'lar çapraz sertifika oluşturmak için bilgi alışverişinde bulunduğunda
 
Sertifika Politikaları ve Sertifika Uygulama Tabloları, Sertifika kullanımıyla ilgili yükümlülükleri ve diğer kuralları açıklayan belgelerin tavsiyesidir.

<details>
#### 6.3.1. PKIX standardisation areas

PKIX is working on the following five areas. 

1.	 Profiles of X.509 v3 Public Key Certificates and X.509 v2 Certificate Revocation Lists (CRLs).  

It describes the basic certificate fields and the extensions to be supported for the Certificates and the Certificate Revocation Lists. Then, it talks about the basic and extended Certificate Path Validation. Finally, it covers the supported cryptographic algorithms. 

2.	 Management protocols.  

First, it discusses the assumptions and restrictions of the protocols. Then, it provides the data structures used for the PKI management messages and defines the functions that conforming implementations must carry out. Finally, it describes a simple protocol for transporting PKI messages. 

3.	 Operational protocols.  

Currently they describe how LDAPv2, FTP and HTTP can be used as operational protocols. 

4.	 Certificate policies and Certificate Practice Statements.  

The purpose of this document is to establish a clear relationship between certificate policies and CPSs, and to present a framework to assist the writers of certificate policies or CPSs with their tasks. In particular, the framework identifies the elements that may need to be considered in formulating a certificate policy or a CPS. The purpose is not to define particular certificate policies or CPSs, per se. 

5.	 Time–stamping and data–certification/validation services.  

There are no RFCs on these services yet, as the documents are still classified as Internet Drafts. 

The time–stamping services define a trusted third–party that creates time stamp tokens in order to indicate that a datum existed at a particular point in time. The data certification and validation services provide certification of possesion of data and claim of possesion of data, and validation of digitally signed documents and certificates. 
 
The relevant Request For Comments (RFC) documents are depicted in the following table 

#### Table 6-2. Table of RFCs for PKIX documents

The specification of the X.509 Certificates is very general and extensible. To ensure interoperability between different Internet-centric implementations, the 

PKIX Working Group defined a profile, which is a description of the format and semantics of certificates and certificate revocation lists for the Internet PKI. 

The operational protocols are the protocols that are required to deliver certificates and CRLs (or status information) to certificate–using client systems. There is an emphasis to have a variety of distribution mechanisms for the certificates and the CRLs, using for example, LDAP, HTTP and FTP. For example, the retrieval of the CRL by a merchant to check whether a certificate is valid, constitutes an operational protocol. 

Management protocols are the protocols that are required to support on–line interactions between PKI user and management entities. The possible set of functions that can be supported by management protocols is 

* registration of entity, that takes place prior to issuing the certificate 
* initialisation, for example generation of key–pair 
* certification, the issuance of the certificate 
* key–pair recovery, the ability to recover lost keys 
* key–pair update, when the certificate expires and a new key–pair and certificate have to be generated 
* revocation request, when an authorised person advices the CA to include a specific certificate into the revocation list 
* cross-certification, when two CAs exchange information in order to generate a cross–certificate 
 
The Certificate Policies and the Certificate Practice Statements are recommendations of documents that will describe the obligations and other rules with regard the usage of the Certificate. 
</details>

#### 6.3.2. Açık anahtar altyapısı işlevselliği

Bu, bir Ortak Anahtar Altyapısının bir işlevsellik veya operasyonudur.

##### Tablo 6-3. PKI işlevselliği

<details>
#### 6.3.2. Public–key infrastructure functionality

This is a functionality or operations of a Public Key Infrastructure. 

##### Table 6-3. PKI functionality
</details>

#### 6.3.3. Açık Anahtar Altyapısı (PKI)

PKI, açık anahtar şifrelemesine dayalı PKC'ler oluşturmak, yönetmek, depolamak, dağıtmak ve iptal etmek için gerekli olan bir dizi donanım, yazılım, kişi, politika ve prosedürdür.

Bir PKI, beş çeşit bileşenden oluşur.

##### Tablo 6-4. PKI bileşenleri

Şekil 6-1'de, PKIX Çalışma Grubu tarafından üstlenilen mimari modelin basitleştirilmiş bir görünüşü bulunmaktadır.

##### Şekil 6-1. PKI Varlıkları

İşletme birimi, yönetim işlemlerini kullanarak sertifika talebini onay için Kayıt Otoritesine gönderir. Aslında onaylanırsa, imzalama için Sertifika Yetkilisine gönderilir. Sertifika Yetkilisi sertifika talebini doğrular ve doğrulamayı geçerse imzalanır ve Sertifika üretilir. Sertifikayı kamuya açmak için CA, Son Kuruluştan tahsilat için Sertifika Deposuna gönderir.

Diyagram, Son Kuruluşun doğrudan CA ile iletişim kurabileceğini göstermektedir. PKIX önerilerine göre, işlevselliği CA içinde uygulamak mümkündür. Bu biraz karışık olmasına rağmen, şema uygulama kararlarına bakılmaksızın olası tüm iletişimleri göstermektedir.

Ayrıca, hem CA hem de RA, havuza Sertifikalar sunacak şekilde gösterilir. Uygulamaya bağlı olarak, ikisinden biri seçildi.

Sertifikaların iptal edilmesi için Sertifikaların oluşturulması ile benzer bir yol izlenir. Son taraf RA'dan Sertifikayı iptal ettirmesini ister; RA bunu kararlaştırır ve muhtemelen CA'ya iletir; CA, iptal listesini günceller ve CRL deposunda yayınlar.

Sonunda, Nihai varlıklar, bir operasyonel protokol kullanarak belirli bir Sertifikanın geçerliliğini kontrol edebilir.

<details>
#### 6.3.3. Public–Key Infrastructure (PKI)

A PKI is a set of hardware, software, people, policies and procedures needed to create, manage, store, distribute and revoke PKCs based on public–key cryptography. 

A PKI consists of five types of componets. 

##### Table 6-4. PKI components

In Figure 6-1 there is a simplified view of the architectural model assumed by the PKIX Working Group. 

##### Figure 6-1. PKI Entities

The End–entity, using management transactions, sends its certificate request to the Registration Authority for approval. If it is actually approved, it is forwarded to the Certification Authority for signing. The Certification Authority verifies the certificate request and if it passes the verification, it is signed and the Certificate is produced. To public the Certificate, the CA sends it to Certificate Repository for collection from the End–entity. 

The diagram shows that the End–entity can communicate directly with the CA. According to the PKIX recommendations, it is possible to implement the functionality within the CA. Although it is a bit confusing, the diagram shows all possible communications, regardless of the implementation decisions. 

Additionally, both the CA and RA are shown to deliver Certificates to the repository. Depending on the implementation, one of the two is chosen. 

For the issue of the revocation of the certificates, a similar course with the generation of the Certificates is taken. The End–entity asks the RA to have its Certificate revoked, the RA decides and possibly forwards it to the CA, the CA updates the revocation list and publishes it on the CRL repository. 

Finally, the End–entities can check the validity of a specific Certificate using an operational protocol. 
</details>

#### 6.3.4. Ayrıcalık Yönetim Altyapısı (PMI)

PMI, Öznitelik Belgelerini oluşturmak, yönetmek, depolamak, dağıtmak ve iptal etmek için gereken donanım, yazılım, kişi, politika ve prosedür setidir.

Bir PMI, beş çeşit üründen oluşur.

##### Tablo 6-5. PMI bileşenleri

Şekil 6-2'de, Nitelik Sertifikalarını içerebilecek değişimlerin bir görünümü bulunmaktadır

##### Şekil 6-2. Öznitelikli Sertifika Değişimleri

Diyagramda gösterildiği gibi itme ve çekme gibi iki tür öznitelik sertifikası dağıtımı vardır.

Bazı ortamlarda, bir istemcinin bir AC'yi bir sunucuya itmesi uygundur. Bu, istemci ve sunucu arasında hiçbir yeni bağlantı gerekli olduğu anlamına gelir. Ayrıca sunuculara hiçbir arama yükü uygulanmadığı anlamına gelir ve bu da performansı artırır.

Diğer durumlarda, bir istemci yalnızca sunucuya kimlik doğrulamasını yapmak için ve sunucunun istemcinin AC'sini bir AC veren kuruluştan veya bir depodan talep etmesi veya çekmesi için daha uygundur. Çekme modelinin en büyük yararı, istemcide veya istemci-sunucu protokolünde değişiklik yapılmaksızın uygulanabilmesidir. Ayrıca, istemcinin haklarının, istemcinin etki alanında değil, sunucunun etki alanı içinde atanması gereken bazı alanlar arası durumlarda daha uygundur.

<details>
#### 6.3.4. Privilege Management Infrastructure (PMI)

PMI is the set of hardware, software, people, policies and procedures needed to create, manage, store, distribute and revoke Attribute Certificates. 

A PMI consists of five types of componets. 

##### Table 6-5. PMI components

In Figure 6-2 there is a view of the exchanges that may involve Attribute Certificates 

##### Figure 6-2. Attribute Certificate Exchanges

There are two types of attribute certificate distribution as show in the diagram, push and pull. 

In some environments it is suitable for a client to push an AC to a server. This means that no new connections between the client and server are required. It also means that no search burden is imposed on servers, which improves performance. 

In other cases, it is more suitable for a client simply to authenticate to the server and for the server to request or pull the client's AC from an AC issuer or a repository. A major benefit of the pull model is that it can be implemented without changes to the client or to the client–server protocol. It is also more suitable for some inter–domain cases where the client's rights should be assigned within the server's domain, rather than within the client's domain. 
</details>
