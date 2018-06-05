[Forma]
Clave=Puesto
Nombre=Puestos de Trabajo
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=General
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=295
PosicionInicialArriba=58
PosicionInicialAltura=326
PosicionInicialAncho=776
PosicionInicialAlturaCliente=615
PosicionColumna1=38
PosicionCol1=293

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Puesto
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Puesto.Puesto
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.Puesto.Puesto]
Carpeta=Lista
Clave=Puesto.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Puesto:Puesto.Puesto)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.Columnas]
Puesto=261
SueldoDef=126
Descripcion=291

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PersonalPropValor
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Puesto:Puesto.Puesto)
AntesExpresiones=Asigna(Info.Rama, <T>PUE<T>)<BR>Asigna(Info.Cuenta, Puesto:Puesto.Puesto)<BR>Asigna(Info.Descripcion, Puesto:Puesto.Puesto)

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
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

[Perfil]
Estilo=Ficha
Pestana=S
Clave=Perfil
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Puesto
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
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
PestanaOtroNombre=S
PestanaNombre=Perfil

[General]
Estilo=Ficha
Clave=General
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Puesto
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
PestanaNombre=General

[General.Puesto.Puesto]
Carpeta=General
Clave=Puesto.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[General.Puesto.Descripcion]
Carpeta=General
Clave=Puesto.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[General.Puesto.SueldoDef]
Carpeta=General
Clave=Puesto.SueldoDef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.TiempoExperienciaRequerido]
Carpeta=Perfil
Clave=Puesto.TiempoExperienciaRequerido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Perfil.Puesto.TiempoExperienciaPuesto]
Carpeta=Perfil
Clave=Puesto.TiempoExperienciaPuesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=20

[Perfil.Puesto.TiempoExperienciaArea]
Carpeta=Perfil
Clave=Puesto.TiempoExperienciaArea
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=20

[Perfil.Puesto.GradoEstudio]
Carpeta=Perfil
Clave=Puesto.GradoEstudio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.Conocimientos]
Carpeta=Perfil
Clave=Puesto.Conocimientos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62x4
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=S

[Perfil.Puesto.Idioma1]
Carpeta=Perfil
Clave=Puesto.Idioma1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=29
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.PorcentajeHablado1]
Carpeta=Perfil
Clave=Puesto.PorcentajeHablado1
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.PorcentajeLectura1]
Carpeta=Perfil
Clave=Puesto.PorcentajeLectura1
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.PorcentajeEscrito1]
Carpeta=Perfil
Clave=Puesto.PorcentajeEscrito1
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.Idioma2]
Carpeta=Perfil
Clave=Puesto.Idioma2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=29
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.PorcentajeHablado2]
Carpeta=Perfil
Clave=Puesto.PorcentajeHablado2
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.PorcentajeLectura2]
Carpeta=Perfil
Clave=Puesto.PorcentajeLectura2
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.PorcentajeEscrito2]
Carpeta=Perfil
Clave=Puesto.PorcentajeEscrito2
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.RequiereViajar]
Carpeta=Perfil
Clave=Puesto.RequiereViajar
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.RequiereAutomovil]
Carpeta=Perfil
Clave=Puesto.RequiereAutomovil
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Perfil.Puesto.RequiereCambioResidencia]
Carpeta=Perfil
Clave=Puesto.RequiereCambioResidencia
Editar=S
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
LineaNueva=S

[Perfil.Puesto.Actividades]
Carpeta=Perfil
Clave=Puesto.Actividades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62x4
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=S

[Perfil.Puesto.EdadMinima]
Carpeta=Perfil
Clave=Puesto.EdadMinima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.EdadMaxima]
Carpeta=Perfil
Clave=Puesto.EdadMaxima
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.EstadoCivil]
Carpeta=Perfil
Clave=Puesto.EstadoCivil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.Sexo]
Carpeta=Perfil
Clave=Puesto.Sexo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.SueldoRangoMinimo]
Carpeta=Perfil
Clave=Puesto.SueldoRangoMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Perfil.Puesto.SueldoRangoMaximo]
Carpeta=Perfil
Clave=Puesto.SueldoRangoMaximo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.PuestoTitulo]
Nombre=PuestoTitulo
Boton=55
NombreDesplegar=&Título(s)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PuestoTitulo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Puesto, Puesto:Puesto.Puesto)


[Perfil.Puesto.RequiereExperiencia]
Carpeta=Perfil
Clave=Puesto.RequiereExperiencia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Perfil.Puesto.Titulado]
Carpeta=Perfil
Clave=Puesto.Titulado
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
Pegado=S

[Acciones.Sucursales]
Nombre=Sucursales
Boton=47
NombreEnBoton=S
NombreDesplegar=Nivel &Sucursal
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PuestoSucursal
Activo=S
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
EjecucionCondicion=ConDatos(Puesto:Puesto.Puesto)
AntesExpresiones=Asigna(Info.Puesto, Puesto:Puesto.Puesto)

[Acciones.Relaciones]
Nombre=Relaciones
Boton=90
NombreDesplegar=Relaciones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PuestoRelacion
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Puesto, Puesto:Puesto.Puesto)

[General.Puesto.Area]
Carpeta=General
Clave=Puesto.Area
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[General.Puesto.Departamento]
Carpeta=General
Clave=Puesto.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[General.Puesto.Objetivo]
Carpeta=General
Clave=Puesto.Objetivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62x6
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=S

[General.Puesto.Alcance]
Carpeta=General
Clave=Puesto.Alcance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62x6
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=S

[Informacion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Información Adicional
Clave=Informacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Puesto
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

[Informacion.Puesto.Funciones]
Carpeta=Informacion
Clave=Puesto.Funciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=62x11
ColorFondo=Blanco
ColorFuente=Negro

[Informacion.Puesto.Responsabilidades]
Carpeta=Informacion
Clave=Puesto.Responsabilidades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=62x11
ColorFondo=Blanco
ColorFuente=Negro

[Informacion.Puesto.Autoridad]
Carpeta=Informacion
Clave=Puesto.Autoridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=62x11
ColorFondo=Blanco
ColorFuente=Negro

[General.Puesto.PuestoReporta]
Carpeta=General
Clave=Puesto.PuestoReporta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[General.Puesto.PuestoSustituye]
Carpeta=General
Clave=Puesto.PuestoSustituye
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro



[Perfil.ListaEnCaptura]
(Inicio)=Puesto.RequiereExperiencia
Puesto.RequiereExperiencia=Puesto.Titulado
Puesto.Titulado=Puesto.TiempoExperienciaRequerido
Puesto.TiempoExperienciaRequerido=Puesto.TiempoExperienciaPuesto
Puesto.TiempoExperienciaPuesto=Puesto.TiempoExperienciaArea
Puesto.TiempoExperienciaArea=Puesto.GradoEstudio
Puesto.GradoEstudio=Puesto.Conocimientos
Puesto.Conocimientos=Puesto.Idioma1
Puesto.Idioma1=Puesto.PorcentajeHablado1
Puesto.PorcentajeHablado1=Puesto.PorcentajeLectura1
Puesto.PorcentajeLectura1=Puesto.PorcentajeEscrito1
Puesto.PorcentajeEscrito1=Puesto.Idioma2
Puesto.Idioma2=Puesto.PorcentajeHablado2
Puesto.PorcentajeHablado2=Puesto.PorcentajeLectura2
Puesto.PorcentajeLectura2=Puesto.PorcentajeEscrito2
Puesto.PorcentajeEscrito2=Puesto.RequiereViajar
Puesto.RequiereViajar=Puesto.RequiereAutomovil
Puesto.RequiereAutomovil=Puesto.RequiereCambioResidencia
Puesto.RequiereCambioResidencia=Puesto.Actividades
Puesto.Actividades=Puesto.EdadMinima
Puesto.EdadMinima=Puesto.EdadMaxima
Puesto.EdadMaxima=Puesto.EstadoCivil
Puesto.EstadoCivil=Puesto.Sexo
Puesto.Sexo=Puesto.SueldoRangoMinimo
Puesto.SueldoRangoMinimo=Puesto.SueldoRangoMaximo
Puesto.SueldoRangoMaximo=(Fin)

[General.ListaEnCaptura]
(Inicio)=Puesto.Puesto
Puesto.Puesto=Puesto.Descripcion
Puesto.Descripcion=Puesto.SueldoDef
Puesto.SueldoDef=Puesto.PuestoReporta
Puesto.PuestoReporta=Puesto.PuestoSustituye
Puesto.PuestoSustituye=Puesto.Area
Puesto.Area=Puesto.Departamento
Puesto.Departamento=Puesto.Objetivo
Puesto.Objetivo=Puesto.Alcance
Puesto.Alcance=(Fin)

[Informacion.ListaEnCaptura]
(Inicio)=Puesto.Funciones
Puesto.Funciones=Puesto.Responsabilidades
Puesto.Responsabilidades=Puesto.Autoridad
Puesto.Autoridad=(Fin)






[Acciones.Competencias]
Nombre=Competencias
Boton=74
NombreEnBoton=S
NombreDesplegar=A&tributos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PuestoCompetencia
Activo=S
ConCondicion=S
Antes=S
Visible=S















EjecucionCondicion=ConDatos(Puesto:Puesto.Puesto)
AntesExpresiones=Asigna(Info.Puesto, Puesto:Puesto.Puesto)












[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=General
General=Perfil
Perfil=Informacion
Informacion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Competencias
Competencias=Sucursales
Sucursales=Propiedades
Propiedades=Excel
Excel=PuestoTitulo
PuestoTitulo=Relaciones
Relaciones=Navegador
Navegador=(Fin)
