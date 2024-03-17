/* /components/Button.tsx  */

type ButtonType = 'button' | 'submit' | 'reset' | undefined;
interface Props {
  children: React.ReactNode;
  styles: string;
  type?: ButtonType;
  title: string;
  disabled?: boolean;
}

const Button = (props:Props) => {
    return (
        <button
        className={`${props.styles} `}
        type={props?.type}
        title={props.title}
        disabled={props?.disabled}
        >
            {props.children}
        </button>
    )
}

export default Button
