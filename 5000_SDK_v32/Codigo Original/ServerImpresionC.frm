[Forma]
Clave=ServerImpresionC
Nombre=Consecutivos de Impresión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=312
PosicionInicialAncho=499
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=262
PosicionInicialArriba=224
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Lista(Empresa, <T>Estación Trabajo: <T>+EstacionTrabajo)
PosicionInicialAlturaCliente=285

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServerImpresion
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.ServerImpresion.Consecutivo]
Carpeta=Lista
Clave=ServerImpresion.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServerImpresion.Activo]
Carpeta=Lista
Clave=ServerImpresion.Activo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=58
Mov=124
Consecutivo=112
Activo=45
Impresora=187
Reporte=106

[Lista.ServerImpresion.Impresora]
Carpeta=Lista
Clave=ServerImpresion.Impresora
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Gris
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ServerImpresion.Mov]
Carpeta=Lista
Clave=ServerImpresion.Mov
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Gris
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=ServerImpresion.Activo
ServerImpresion.Activo=ServerImpresion.Consecutivo
ServerImpresion.Consecutivo=ServerImpresion.Mov
ServerImpresion.Mov=ServerImpresion.Impresora
ServerImpresion.Impresora=(Fin)
