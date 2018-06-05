[Forma]
Clave=PersonalCat
Nombre=Categorías del Personal
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAltura=340
PosicionInicialAncho=812
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=106
PosicionInicialArriba=210
PosicionInicialAlturaCliente=313

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalCat
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaNombre=Lista
HojaMantenerSeleccion=S
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.PersonalCat.Categoria]
Carpeta=Lista
Clave=PersonalCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
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
Categoria=160
PeriodoTipo=108
FormaPago=102
Jornada=101
SueldoMaximo=106
SueldoMinimo=102
Descripcion=234
SueldoMedio=91
FactorCANAPAT=85

[Detalle.PersonalCat.Categoria]
Carpeta=Detalle
Clave=PersonalCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PersonalCat.PeriodoTipo]
Carpeta=Detalle
Clave=PersonalCat.PeriodoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.PersonalCat.FormaPago]
Carpeta=Detalle
Clave=PersonalCat.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PersonalCat.Jornada]
Carpeta=Detalle
Clave=PersonalCat.Jornada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=&Propiedades
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PersonalPropValor
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(PersonalCat:PersonalCat.Categoria)
AntesExpresiones=Asigna(Info.Rama, <T>CAT<T>)<BR>Asigna(Info.Cuenta, PersonalCat:PersonalCat.Categoria)<BR>Asigna(Info.Descripcion, PersonalCat:PersonalCat.Categoria)

[Detalle.PersonalCat.SueldoMaximo]
Carpeta=Detalle
Clave=PersonalCat.SueldoMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PersonalCat.SueldoMinimo]
Carpeta=Detalle
Clave=PersonalCat.SueldoMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Lista.PersonalCat.SueldoMaximo]
Carpeta=Lista
Clave=PersonalCat.SueldoMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalCat.SueldoMinimo]
Carpeta=Lista
Clave=PersonalCat.SueldoMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Lista.PersonalCat.Descripcion]
Carpeta=Lista
Clave=PersonalCat.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalCat.SueldoMedio]
Carpeta=Lista
Clave=PersonalCat.SueldoMedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalCat.FactorCANAPAT]
Carpeta=Lista
Clave=PersonalCat.FactorCANAPAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Propiedades
Propiedades=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PersonalCat.Categoria
PersonalCat.Categoria=PersonalCat.Descripcion
PersonalCat.Descripcion=PersonalCat.SueldoMinimo
PersonalCat.SueldoMinimo=PersonalCat.SueldoMedio
PersonalCat.SueldoMedio=PersonalCat.SueldoMaximo
PersonalCat.SueldoMaximo=PersonalCat.FactorCANAPAT
PersonalCat.FactorCANAPAT=(Fin)
