
[Forma]
Clave=TipoLicenciamiento
Icono=0
CarpetaPrincipal=TipoLicenciamiento
Modulos=(Todos)
Nombre=Tipos de Licenciamiento

ListaCarpetas=TipoLicenciamiento
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
PosicionInicialIzquierda=429
PosicionInicialArriba=247
PosicionInicialAlturaCliente=357
PosicionInicialAncho=274
[TipoLicenciamiento]
Estilo=Hoja
Clave=TipoLicenciamiento
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoLicenciamiento
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoLicenciamiento.Descripcion
CarpetaVisible=S

[TipoLicenciamiento.TipoLicenciamiento.Descripcion]
Carpeta=TipoLicenciamiento
Clave=TipoLicenciamiento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

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
[TipoLicenciamiento.Columnas]
Descripcion=244


[Acciones.EnvioExcel]
Nombre=EnvioExcel
Boton=67
NombreDesplegar=EnviarExcel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=EnvioExcel
EnvioExcel=(Fin)
