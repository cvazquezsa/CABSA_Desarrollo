[Forma]
Clave=Cubo
Nombre=Cubos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=401
PosicionInicialAncho=743
PosicionColumna1=47
PosicionInicialIzquierda=588
PosicionInicialArriba=378
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=338

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Cubo
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.Cubo.Cubo]
Carpeta=Ficha
Clave=Cubo.Cubo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cubo.Nombre]
Carpeta=Ficha
Clave=Cubo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cubo.Descripcion]
Carpeta=Ficha
Clave=Cubo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cubo.Vista]
Carpeta=Ficha
Clave=Cubo.Vista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cubo.UltimaActualizacion]
Carpeta=Ficha
Clave=Cubo.UltimaActualizacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Cubo.Instalado]
Carpeta=Ficha
Clave=Cubo.Instalado
Editar=N
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=N

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cubo
Fuente={Tahoma, 8, Negro, []}
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
HojaMantenerSeleccion=S

[Lista.Cubo.Cubo]
Carpeta=Lista
Clave=Cubo.Cubo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cubo.Nombre]
Carpeta=Lista
Clave=Cubo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Cubo=110
Nombre=193

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
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.CuboMedida]
Nombre=CuboMedida
Boton=99
NombreDesplegar=&Medidas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CuboMedida
Activo=S
Visible=S
NombreEnBoton=S
GuardarAntes=S
ConCondicion=S
Antes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(Cubo:Cubo.Cubo) y ConDatos(Cubo:Cubo.Vista)
AntesExpresiones=Asigna(Info.Cubo, Cubo:Cubo.Cubo)<BR>Asigna(Info.Vista, Cubo:Cubo.Vista)

[Acciones.CuboDimension]
Nombre=CuboDimension
Boton=98
NombreEnBoton=S
NombreDesplegar=&Dimensiones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CuboDimension
Activo=S
Visible=S
ConCondicion=S
GuardarAntes=S
EjecucionCondicion=ConDatos(Cubo:Cubo.Cubo) y ConDatos(Cubo:Cubo.Vista)
Antes=S
AntesExpresiones=Asigna(Info.Cubo, Cubo:Cubo.Cubo)<BR>Asigna(Info.Vista, Cubo:Cubo.Vista)
DespuesGuardar=S

[Acciones.CuboFormula]
Nombre=CuboFormula
Boton=10
NombreEnBoton=S
NombreDesplegar=&Fórmulas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CuboFormula
Activo=S
Visible=S
ConCondicion=S
GuardarAntes=S
EjecucionCondicion=ConDatos(Cubo:Cubo.Cubo) y ConDatos(Cubo:Cubo.Vista)
Antes=S
AntesExpresiones=Asigna(Info.Cubo, Cubo:Cubo.Cubo)<BR>Asigna(Info.Vista, Cubo:Cubo.Vista)
DespuesGuardar=S

[Ficha.Cubo.Activo]
Carpeta=Ficha
Clave=Cubo.Activo
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cubo.EsCuboRemoto]
Carpeta=Ficha
Clave=Cubo.EsCuboRemoto
Editar=S
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Remoto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cubo Remoto
Clave=Remoto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Cubo
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
CondicionVisible=Cubo:Cubo.EsCuboRemoto

[Remoto.Cubo.ServidorRemoto]
Carpeta=Remoto
Clave=Cubo.ServidorRemoto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Remoto.Cubo.BaseDatosRemoto]
Carpeta=Remoto
Clave=Cubo.BaseDatosRemoto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Remoto.Cubo.CuboRemoto]
Carpeta=Remoto
Clave=Cubo.CuboRemoto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cubo.EnviarPDF]
Carpeta=Ficha
Clave=Cubo.EnviarPDF
Editar=S
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Cubo.EnviarXLS]
Carpeta=Ficha
Clave=Cubo.EnviarXLS
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cubo.EnviarRTF]
Carpeta=Ficha
Clave=Cubo.EnviarRTF
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cubo.PermiteCrearVistas]
Carpeta=Ficha
Clave=Cubo.PermiteCrearVistas
Editar=S
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cubo.PermiteEliminarVistas]
Carpeta=Ficha
Clave=Cubo.PermiteEliminarVistas
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Campos]
Nombre=Campos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Campos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CuboCampo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Cubo:Cubo.Cubo)
Antes=S
AntesExpresiones=Asigna(Info.Cubo, Cubo:Cubo.Cubo)
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Remoto
Remoto=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=CuboDimension
CuboDimension=CuboMedida
CuboMedida=CuboFormula
CuboFormula=Campos
Campos=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Cubo.Cubo
Cubo.Cubo=Cubo.Nombre
Cubo.Nombre=Cubo.Descripcion
Cubo.Descripcion=Cubo.Vista
Cubo.Vista=Cubo.EnviarPDF
Cubo.EnviarPDF=Cubo.EnviarXLS
Cubo.EnviarXLS=Cubo.EnviarRTF
Cubo.EnviarRTF=Cubo.PermiteCrearVistas
Cubo.PermiteCrearVistas=Cubo.PermiteEliminarVistas
Cubo.PermiteEliminarVistas=Cubo.EsCuboRemoto
Cubo.EsCuboRemoto=Cubo.UltimaActualizacion
Cubo.UltimaActualizacion=Cubo.Instalado
Cubo.Instalado=Cubo.Activo
Cubo.Activo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cubo.Cubo
Cubo.Cubo=Cubo.Nombre
Cubo.Nombre=(Fin)

[Remoto.ListaEnCaptura]
(Inicio)=Cubo.ServidorRemoto
Cubo.ServidorRemoto=Cubo.BaseDatosRemoto
Cubo.BaseDatosRemoto=Cubo.CuboRemoto
Cubo.CuboRemoto=(Fin)
