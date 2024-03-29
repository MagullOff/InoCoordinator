# ino_coordinator

Aplikacja służąca do koordynacji gier terenowych.

Zobacz [backend](https://github.com/MagullOff/InoCoordinator-Backend) projektu

## Opis projektu

Aplikacja pozwala organizatorom gier terenowych tworzyć wydarzenia do których przypisywani będą użytkownicy. Ci zaś będą mieli możliwość skanowania kodów QR dostępnych na rozmieszczonych w terenie punktach gry. W ten sposób uczestnicy będą mieli informacje na temat swojego postępu w grze, a organizator na temat tego jak radzą sobie wszyscy uczestnicy. Organizator posiada również możliwości tworzenia poszczególnych elementów wydarzenia - punktów oraz graczy.

## Logowanie i Rejestracja
Rejestrować się do aplikacji mogą jedynie Organizatorzy gier. Konta użytkowników są przez nich tworzone i przypisane do konkretnego wydarzenia. Do rejestracji potrzebny jest login oraz email. Kod dostępu dla organizatora generowany jest automatycznie. 

![Obraz prezentujący ekran logowania](images/signUp.png)
![Obraz prezentujący ekran logowania](images/showCode.png)

Aby zalogować się do aplikacji wprowadzamy jedynie kod dostępu. Aplikacja sama sprawdza czy jesteśmy graczem czy organizatorem i przekierowuje nas do odpowiedniego ekranu.

![Obraz prezentujący ekran logowania](images/login.png)

Przy logowaniu i rejestracji (jak i kilku innych ekranach w innych częściach aplikacji) mamy do czynienia z formami z walidacją pochodzącą od providerów.

## Autoryzacja
Autoryzowanie użytkowników odbywa się poprzez prosty model tokena w formacie `id-użytkownika@kod-dostępu`. Token ten przesyłany jest w nagłówku autoryzacji podczas zapytań do api.

## Flow gracza
Po zalogowaniu się gracz widzi ekran ze statystykami dotyczącymi swojego działania na wydarzeniu. Na ekranie tym mieści się poziom ukończenia całego wydarzenia oraz lista punktów z informacją czy i o której zostały one złapane. 

![Obraz prezentujący ekran gracza](images/player.png)

Dodatkowo w prawym dolnym rogu znajduje się przycisk, którego naciśnięcie przenosi nas do sceny skanowania kodu qr, gdzie po skanowaniu kodu (jeżeli będzie on prawidłowy) zostanie graczowi przyznany punkt.

## Flow organizatora
Po zalogowaniu się organizator widzi ekran na którym pokazane są wszystkie wydarzenia danego użytkownika. Przycisk w prawym dolnym rogu przenosi nas do formularza tworzenia kolejnego wydarzenia. Kliknięcie któregokolwiek z wydarzeń przenosi nas do widoku danego wydarzenia, gdzie pokazane są przyciski pozwalające przejść do konkretnych informacji na temat tego eventu.

![Obraz prezentujący ekran gracza](images/events.png)

Po kliknięciu `Show players` przeniesiemy się do widoku listy graczy danego wydarzenia. W tym widoku mamy również możliwość przeniesienia się do formularza dodawania nowego gracza dla wydarzenia. Przy każdym z użytkowników widoczny jest ich kod potrzebny do zalogowania się. Po kliknięciu w użytkownika przenosimy się do znanego już widoku postępu użytkownika.

Po kliknięciu `Show points` przeniesiemy się do widoku listy punktów danego wydarzenia. W tym widoku mamy również możliwość przeniesienia się do formularza dodawania nowego punktu dla wydarzenia. Przy każdym z użytkowników widoczny jest ich tekst kodu który należy użyć do utworzenia kodu QR dla tego punktu za pomocą innego programu.

![Obraz prezentujący ekran gracza](images/players.png)
![Obraz prezentujący ekran gracza](images/points.png)

## Kwestia backendu
Aktualnie backend projektu nie jest zhostowany na żadnym serwerze w internecie. Aplikacja przystosowania jest do testowania na komputerze, na którym backend ten jest przypisany do adresu `localhost:7777`.

## Platformy
Aplikacja działa na systemie android i IOS
