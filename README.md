# ino_coordinator

Aplikacja służąca do koordynacji gier terenowych.

Zobacz [backend](https://github.com/MagullOff/InoCoordinator-Backend) projektu

## Opis projektu

Aplikacja pozwala organizatorom gier terenowych tworzyć wydarzenia do których przypisywani będą użytkownicy. Ci zaś będą mieli możliwość skanowania kodów QR dostępnych na punktach gry. W ten sposób uczestnicy będą mieli informacje na temat swojego postępu w grze, a organizator na temat tego jak radzą sobie wszyscy uczestnicy. Organizator posiada również możliwości tworzenia poszczególnych elementów wydarzenia - punktów oraz graczy.

## Logowanie i Rejestracja
Rejestrować się do aplikacji mogą jedynie Organizatorzy gier. Konta użytkowników są przez nich tworzone i przypisane do konkretnego wydarzenia. Do rejestracji potrzebny jest login oraz email. Kod dostępu dla organizatora generowany jest automatycznie. 

Aby zalogować się do aplikacji wprowadzamy jedynie kod dostępu. Aplikacja sama sprawdza czy jesteśmy graczem czy organizatorem i przekierowuje nas do odpowiedniego ekranu.

## Autoryzacja
Autoryzowanie użytkowników odbywa się poprzez prosty model tokena w formacie `id-użytkownika@kod-dostępu`. Token ten przesyłany jest w nagówku autoryzacji podczas zapytań do api.

## Flow gracza
Po zalogowaniu się gracz widzi ekran ze statystykami dotyczącymi swojego działania na wydarzeniu. Na ekranie tym mieści się poziom ukończenia całego wydarzenia oraz lista punktów z informacją czy i o której zostały one złapane. 

Dodatkowo w prawym dolnym rogu znajduje się przycisk którego naciśnięcie przenosi nas do sceny kasowania kodu qr, gdzie po skasowaniu kodu (jeżeli będzie on prawidłowy) zostanie drużynie przyznany punkt.

## Flow organizatora
Po zalogowaniu się organizator widzi ekran na którym pokazane są wszystkie wydarzenia danego użytkownika. Przycisk w prawym dolnym rogu przenosi nas do formularza tworzenia kolejnego wydarzenia. Kliknięcie któregokolwiek z wydarzeń przenosi nas do widoku danego wydarzenia, gdzie pokazane są przyciski pozwalające przejść do konkretnych informacji na temat tego eventu.

Po kliknięciu `Show players` przeniesiemy się do widoku listy graczy danego wydarzenia. W tym widoku mamy również możliwość przeniesienia się do formularza dodawania nowego gracza dla wydarzenia. Przy każdym z użytkowników widoczny jest ich kod potrzebny do zalogowania się. Po kliknięciu w użytkownika przenosimy się do znanego już widoku postępu użytkownika.

Po kliknięciu `Show points` przeniesiemy się do widoku listy punktów danego wydarzenia. W tym widoku mamy również możliwość przeniesienia się do formularza dodawania nowego punktu dla wydarzenia. Przy każdym z użytkowników widoczny jest ich tekst kodu który należy użyć do utworzenia kodu QR dla tego punktu.
