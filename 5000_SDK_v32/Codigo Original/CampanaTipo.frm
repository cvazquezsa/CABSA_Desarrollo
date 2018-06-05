[Forma]
Clave=CampanaTipo
Nombre=Tipos Campañas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=664
PosicionInicialArriba=361
PosicionInicialAlturaCliente=442
PosicionInicialAncho=592
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=335

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaTipo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CampanaTipo.CampanaTipo
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.CampanaTipo.CampanaTipo]
Carpeta=Lista
Clave=CampanaTipo.CampanaTipo
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

[Lista.Columnas]
CampanaTipo=304

[Acciones.Encuesta]
Nombre=Encuesta
Boton=47
NombreEnBoton=S
NombreDesplegar=&Encuesta
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CampanaTipoEncuesta
Activo=S
ConCondicion=S
Visible=S
Antes=S
EjecucionCondicion=ConDatos(CampanaTipo:CampanaTipo.CampanaTipo)
AntesExpresiones=Asigna(Info.Tipo, CampanaTipo:CampanaTipo.CampanaTipo)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CampanaTipo
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

[Ficha.CampanaTipo.ParaProspectos]
Carpeta=Ficha
Clave=CampanaTipo.ParaProspectos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipo.ParaClientes]
Carpeta=Ficha
Clave=CampanaTipo.ParaClientes
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipo.ParaProveedores]
Carpeta=Ficha
Clave=CampanaTipo.ParaProveedores
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipo.ParaPersonal]
Carpeta=Ficha
Clave=CampanaTipo.ParaPersonal
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipo.ParaAgentes]
Carpeta=Ficha
Clave=CampanaTipo.ParaAgentes
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Acciones.Cargos]
Nombre=Cargos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Cargos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CampanaTipoCargo
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CampanaTipo:CampanaTipo.CampanaTipo)
Antes=S
AntesExpresiones=Asigna(Info.Tipo, CampanaTipo:CampanaTipo.CampanaTipo)

[Encuesta]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Encuesta Web
Clave=Encuesta
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CampanaTipo
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
CondicionVisible=CampanaTipo:CampanaTipo.EncuestaWeb

[Encuesta.CampanaTipo.EncuestaEtiqueta]
Carpeta=Encuesta
Clave=CampanaTipo.EncuestaEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Encuesta.CampanaTipo.EncuestaPagina]
Carpeta=Encuesta
Clave=CampanaTipo.EncuestaPagina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Encuesta.WebPagina.Nombre]
Carpeta=Encuesta
Clave=WebPagina.Nombre
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CampanaTipo.EncuestaWeb]
Carpeta=Ficha
Clave=CampanaTipo.EncuestaWeb
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Situaciones]
Nombre=Situaciones
Boton=47
NombreEnBoton=S
NombreDesplegar=&Situaciones
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CampanaTipoSituacion
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(CampanaTipo:CampanaTipo.CampanaTipo)
AntesExpresiones=Asigna(Info.Tipo, CampanaTipo:CampanaTipo.CampanaTipo)

[Califica.CampanaTipo.CalificaMinimo]
Carpeta=Califica
Clave=CampanaTipo.CalificaMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Califica.CampanaTipo.CalificaSituacion]
Carpeta=Califica
Clave=CampanaTipo.CalificaSituacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Calificaciones]
Nombre=Calificaciones
Boton=47
NombreEnBoton=S
NombreDesplegar=&Calificaciones
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CampanaTipoCalificacion
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CampanaTipo:CampanaTipo.CampanaTipo)
Antes=S
AntesExpresiones=Asigna(Info.Tipo, CampanaTipo:CampanaTipo.CampanaTipo)

[Ficha.CampanaTipo.CancelarSuscripcion]
Carpeta=Ficha
Clave=CampanaTipo.CancelarSuscripcion
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipo.CancelarSuscripcionEtiqueta]
Carpeta=Ficha
Clave=CampanaTipo.CancelarSuscripcionEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipo.Sitio]
Carpeta=Ficha
Clave=CampanaTipo.Sitio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebSitio.Nombre]
Carpeta=Ficha
Clave=WebSitio.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CampanaTipo.CancelarSuscripcionSituacion]
Carpeta=Ficha
Clave=CampanaTipo.CancelarSuscripcionSituacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Encuesta
Encuesta=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Situaciones
Situaciones=Encuesta
Encuesta=Calificaciones
Calificaciones=Cargos
Cargos=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CampanaTipo.ParaProspectos
CampanaTipo.ParaProspectos=CampanaTipo.ParaClientes
CampanaTipo.ParaClientes=CampanaTipo.ParaProveedores
CampanaTipo.ParaProveedores=CampanaTipo.ParaPersonal
CampanaTipo.ParaPersonal=CampanaTipo.ParaAgentes
CampanaTipo.ParaAgentes=CampanaTipo.Sitio
CampanaTipo.Sitio=WebSitio.Nombre
WebSitio.Nombre=CampanaTipo.EncuestaWeb
CampanaTipo.EncuestaWeb=CampanaTipo.CancelarSuscripcion
CampanaTipo.CancelarSuscripcion=CampanaTipo.CancelarSuscripcionEtiqueta
CampanaTipo.CancelarSuscripcionEtiqueta=CampanaTipo.CancelarSuscripcionSituacion
CampanaTipo.CancelarSuscripcionSituacion=(Fin)

[Encuesta.ListaEnCaptura]
(Inicio)=CampanaTipo.EncuestaPagina
CampanaTipo.EncuestaPagina=WebPagina.Nombre
WebPagina.Nombre=CampanaTipo.EncuestaEtiqueta
CampanaTipo.EncuestaEtiqueta=(Fin)
