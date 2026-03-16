import es from './locales/es';
import en from './locales/en';
import pt from './locales/pt';

export type Locale = 'es' | 'en' | 'pt';

const translations: Record<Locale, typeof es> = { es, en, pt };

export function useTranslations(lang: string) {
  const locale = (lang in translations ? lang : 'es') as Locale;
  return translations[locale];
}
