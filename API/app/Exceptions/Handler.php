<?php

namespace App\Exceptions;
use Illuminate\Validation\ValidationException;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;

class Handler extends ExceptionHandler
{
    /**
     * A list of exception types with their corresponding custom log levels.
     *
     * @var array<class-string<\Throwable>, \Psr\Log\LogLevel::*>
     */
    protected $levels = [
        //
    ];

    /**
     * A list of the exception types that are not reported.
     *
     * @var array<int, class-string<\Throwable>>
     */
    protected $dontReport = [
        //
    ];

    /**
     * A list of the inputs that are never flashed to the session on validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     *
     * @return void
     */
    public function register()
    {
        $this->renderable(function(Throwable $e, $request) {
            return $this->handleException($request, $e);
        });
    }

    public function handleException($request, Throwable $exception)
    {
        if ($exception instanceof ValidationException) {
            $json = [
                'error' => $exception->validator->errors(),
                'status_code' => $exception->getStatusCode()
            ];
        } elseif ($exception instanceof AuthorizationException) {
            $json = [
                'error' => 'You are not allowed to do this action.',
                'status_code' => 403
            ];
        } elseif ($exception instanceof NotFoundHttpException) {
            $json = [
                'error' => 'Sorry, the page you are looking for could not be found.',
                'status_code' => 403,
            ];
        }
        else {
            $json = [
                'error' => (app()->environment() !== 'production')
                    ? $exception->getMessage()
                    : 'An error has occurred.',
                'status_code' => $exception->getStatusCode()
            ];
        }

        return response()->json($json, $exception->getStatusCode());
    }
}
