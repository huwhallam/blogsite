import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const commons = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/commons' }),
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    description: z.string().optional(),
    tags: z.array(z.string()).optional(),
  }),
});

const abundance = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/abundance' }),
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    description: z.string().optional(),
    tags: z.array(z.string()).optional(),
  }),
});

export const collections = { commons, abundance };
