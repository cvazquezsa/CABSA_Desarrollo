
[Forma]
Clave=TipoSistemaActual
Icono=0
Modulos=(Todos)
Nombre=Tipos de Sistema Actual

ListaCarpetas=TipoSistemaActual
CarpetaPrincipal=TipoSistemaActual
PosicionInicialIzquierda=499
PosicionInicialArriba=202
PosicionInicialAlturaCliente=361
PosicionInicialAncho=281
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[TipoSistemaActual]
Estilo=Hoja
Clave=TipoSistemaActual
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoSistemaActual
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoSistemaActual.Descripcion
CarpetaVisible=S

[TipoSistemaActual.TipoSistemaActual.Descripcion]
Carpeta=TipoSistemaActual
Clave=TipoSistemaActual.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[TipoSistemaActual.Columnas]
Descripcion=252

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S
[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Envio a Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
