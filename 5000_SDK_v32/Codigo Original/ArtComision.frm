[Forma]
Clave=ArtComision
Nombre=Tipos de Comisiones 
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=294
PosicionInicialArriba=230
PosicionInicialAltura=300
PosicionInicialAncho=436
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtComision
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.ArtComision.Comision]
Carpeta=Lista
Clave=ArtComision.Comision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtComision.Porcentaje]
Carpeta=Lista
Clave=ArtComision.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Comision=192
Porcentaje=46
Tipo=84
Importe=82

[Lista.ArtComision.Tipo]
Carpeta=Lista
Clave=ArtComision.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Lista.ArtComision.Importe]
Carpeta=Lista
Clave=ArtComision.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtComisionHist]
Nombre=ArtComisionHist
Boton=53
NombreEnBoton=S
NombreDesplegar=&Histórico de Cambios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtComisionHist
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtComision:ArtComision.Comision)
AntesExpresiones=Asigna(Info.Clave, ArtComision:ArtComision.Comision)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=ArtComisionHist
ArtComisionHist=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtComision.Comision
ArtComision.Comision=ArtComision.Tipo
ArtComision.Tipo=ArtComision.Porcentaje
ArtComision.Porcentaje=ArtComision.Importe
ArtComision.Importe=(Fin)
