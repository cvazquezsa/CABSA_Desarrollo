
[Forma]
Clave=TipoRegistro
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Tipo de Registro
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=434
PosicionInicialAncho=847
PosicionCol1=461
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=296
PosicionInicialArriba=219
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoRegistro
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoRegistro.TipoRegistro<BR>TipoRegistro.Concepto
CarpetaVisible=S

[Lista.TipoRegistro.TipoRegistro]
Carpeta=Lista
Clave=TipoRegistro.TipoRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TipoRegistro.Concepto]
Carpeta=Lista
Clave=TipoRegistro.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=TipoRegistro
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.TipoRegistro.TipoRegistro]
Carpeta=Ficha
Clave=TipoRegistro.TipoRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.TipoRegistro.Concepto]
Carpeta=Ficha
Clave=TipoRegistro.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.TipoRegistro.Mascara]
Carpeta=Ficha
Clave=TipoRegistro.Mascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.TipoRegistro.TipoContacto]
Carpeta=Ficha
Clave=TipoRegistro.TipoContacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.TipoRegistro.Referencia]
Carpeta=Ficha
Clave=TipoRegistro.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.TipoRegistro.VigenciaD]
Carpeta=Ficha
Clave=TipoRegistro.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=12
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegar]
Nombre=Navegar
Boton=0
NombreDesplegar=Navegar
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

EspacioPrevio=S
[Lista.Columnas]
TipoRegistro=124
Concepto=304



















[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Historico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=formas
ClaveAccion=TipoRegistroD
Activo=S
ConCondicion=S
Antes=S
Visible=S



























































GuardarAntes=S














EjecucionCondicion=ConDatos(TipoRegistro:TipoRegistro.TipoRegistro)
AntesExpresiones=Asigna(Info.Nombre,TipoRegistro:TipoRegistro.TipoRegistro)
DespuesGuardar=S








[Ficha.ListaEnCaptura]
(Inicio)=TipoRegistro.TipoRegistro
TipoRegistro.TipoRegistro=TipoRegistro.Concepto
TipoRegistro.Concepto=TipoRegistro.Mascara
TipoRegistro.Mascara=TipoRegistro.TipoContacto
TipoRegistro.TipoContacto=TipoRegistro.Referencia
TipoRegistro.Referencia=TipoRegistro.VigenciaD
TipoRegistro.VigenciaD=TipoRegistro.TipoID
TipoRegistro.TipoID=(Fin)

[Ficha.TipoRegistro.TipoID]
Carpeta=Ficha
Clave=TipoRegistro.TipoID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Detalle
Detalle=Navegar
Navegar=(Fin)
