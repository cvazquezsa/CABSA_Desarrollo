[Forma]
Clave=TablaComisionEsp
Nombre=Tablas Comisiones Especiales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=323
PosicionInicialArriba=198
PosicionInicialAlturaCliente=338
PosicionInicialAncho=377
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaComisionEsp
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
HojaMantenerSeleccion=S
HojaMostrarColumnas=S
HojaAjustarColumnas=S
HojaTitulos=S

[Lista.TablaComisionEsp.TablaComisionEsp]
Carpeta=Lista
Clave=TablaComisionEsp.TablaComisionEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
TablaComisionEsp=222
Tipo=125

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

[Acciones.Tabla]
Nombre=Tabla
Boton=47
NombreEnBoton=S
NombreDesplegar=&Editar Tabla
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TablaComisionEspD
Activo=S
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
EjecucionCondicion=ConDatos(TablaComisionEsp:TablaComisionEsp.TablaComisionEsp)
AntesExpresiones=Asigna(Info.Tabla, TablaComisionEsp:TablaComisionEsp.TablaComisionEsp)<BR>Asigna(Info.Tipo, TablaComisionEsp:TablaComisionEsp.Tipo)

[Lista.TablaComisionEsp.Tipo]
Carpeta=Lista
Clave=TablaComisionEsp.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Tabla
Tabla=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TablaComisionEsp.TablaComisionEsp
TablaComisionEsp.TablaComisionEsp=TablaComisionEsp.Tipo
TablaComisionEsp.Tipo=(Fin)
