
[Forma]
Clave=TipoCoordinacionEvaluacion
Icono=0
Modulos=(Todos)
Nombre=Tipos de Coordinaci�n de Evaluacion

ListaCarpetas=TipoCoordinacionEvaluacion
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
CarpetaPrincipal=TipoCoordinacionEvaluacion


PosicionInicialIzquierda=499
PosicionInicialArriba=207
PosicionInicialAlturaCliente=352
PosicionInicialAncho=332
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=ventana
ClaveAccion=aceptar
Activo=S
Visible=S

GuardarAntes=S
[Acciones.EnvioExcel]
Nombre=EnvioExcel
Boton=67
NombreDesplegar=Envio a Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S




[TipoCoordinacionEvaluacion]
Estilo=Hoja
Clave=TipoCoordinacionEvaluacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoCoordinaci�nEvaluacion
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoCoordinaci�nEvaluacion.Descripcion
CarpetaVisible=S

[TipoCoordinacionEvaluacion.TipoCoordinaci�nEvaluacion.Descripcion]
Carpeta=TipoCoordinacionEvaluacion
Clave=TipoCoordinaci�nEvaluacion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro


[TipoCoordinacionEvaluacion.Columnas]
Descripcion=302











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=EnvioExcel
EnvioExcel=(Fin)
