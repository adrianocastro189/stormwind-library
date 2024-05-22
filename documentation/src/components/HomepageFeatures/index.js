import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Client agnostic',
    image: 'img/index-client-agnostic.jpg',
    description: (
      <>
        Designed to work on any World of Warcraft client, regardless of the expansion.
      </>
    ),
  },
  {
    title: 'Built on demand',
    image: 'img/index-built-on-demand.jpg',
    description: (
      <>
        Built on demand in conjunction with the addons that use it.
      </>
    ),
  },
  {
    title: 'Open source',
    image: 'img/index-open-source.jpg',
    description: (
      <>
        The library is open-source, and addon developers are free to collaborate.
      </>
    ),
  },
];

function Feature({image, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <img src={image} />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
