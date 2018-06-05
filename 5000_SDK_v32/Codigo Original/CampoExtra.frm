[Forma]
Clave=CampoExtra
Nombre=Campos Extras
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=405
PosicionInicialAncho=795
PosicionInicialIzquierda=242
PosicionInicialArriba=296
PosicionColumna1=42
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=332

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampoExtra
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=CampoExtra.CampoExtra
HojaMantenerSeleccion=S

[Lista.CampoExtra.CampoExtra]
Carpeta=Lista
Clave=CampoExtra.CampoExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
CampoExtra=300
Nombre=604
AyudaTipo=304
AyudaReferencia=304
ValidacionTipo=304
ValidacionReferencia=304
Mascara=304

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CampoExtra
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

[Ficha.CampoExtra.Nombre]
Carpeta=Ficha
Clave=CampoExtra.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampoExtra.AyudaTipo]
Carpeta=Ficha
Clave=CampoExtra.AyudaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.CampoExtra.ValidacionTipo]
Carpeta=Ficha
Clave=CampoExtra.ValidacionTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.CampoExtra.Mascara]
Carpeta=Ficha
Clave=CampoExtra.Mascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
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

[Ficha.CampoExtra.Prefijo]
Carpeta=Ficha
Clave=CampoExtra.Prefijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampoExtra.Base]
Carpeta=Ficha
Clave=CampoExtra.Base
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampoExtra.Sufijo]
Carpeta=Ficha
Clave=CampoExtra.Sufijo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ayuda]
Nombre=Ayuda
Boton=47
NombreEnBoton=S
NombreDesplegar=&Ayuda
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
ConCondicion=S
Antes=S
Visible=S
Expresion=Caso CampoExtra:CampoExtra.AyudaTipo<BR>  Es <T>Lista<T> Entonces Forma(<T>CampoExtraAyudaLista<T>)<BR>  Es <T>Lista Opcional<T> Entonces Forma(<T>CampoExtraAyudaLista<T>)<BR>  Es <T>Expresion<T> Entonces Forma(<T>CampoExtraAyudaExpresion<T>)<BR>  Es <T>Expresion Opcional<T> Entonces Forma(<T>CampoExtraAyudaExpresion<T>)<BR>  Es <T>Forma<T> Entonces Forma(<T>CampoExtraAyudaExpresion<T>)<BR>Fin
ActivoCondicion=ConDatos(CampoExtra:CampoExtra.AyudaTipo)
EjecucionCondicion=ConDatos(CampoExtra:CampoExtra.CampoExtra)
AntesExpresiones=Asigna(Info.CampoExtra, CampoExtra:CampoExtra.CampoExtra)<BR>Asigna(Info.Nombre, CampoExtra:CampoExtra.Nombre)<BR>Asigna(Info.Referencia, CampoExtra:CampoExtra.AyudaReferencia)

[Ficha.CampoExtra.AyudaReferencia]
Carpeta=Ficha
Clave=CampoExtra.AyudaReferencia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=N

[Ficha.CampoExtra.ValidacionReferencia]
Carpeta=Ficha
Clave=CampoExtra.ValidacionReferencia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Ficha.CampoExtra.ValidacionCampo]
Carpeta=Ficha
Clave=CampoExtra.ValidacionCampo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Validacion]
Nombre=Validacion
Boton=47
NombreEnBoton=S
NombreDesplegar=&Validación
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CampoExtraValidacionExpresion
ConCondicion=S
Visible=S
Antes=S
ActivoCondicion=CampoExtra:CampoExtra.ValidacionTipo=<T>Expresion<T>
EjecucionCondicion=ConDatos(CampoExtra:CampoExtra.CampoExtra)
AntesExpresiones=Asigna(Info.CampoExtra, CampoExtra:CampoExtra.CampoExtra)<BR>Asigna(Info.Nombre, <T>Especifique [Valor] o [Campo]<T>)<BR>Asigna(Info.Referencia, CampoExtra:CampoExtra.ValidacionReferencia)

[Ficha.CampoExtra.ValidacionTabla]
Carpeta=Ficha
Clave=CampoExtra.ValidacionTabla
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Ayuda
Ayuda=Validacion
Validacion=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CampoExtra.Prefijo
CampoExtra.Prefijo=CampoExtra.Base
CampoExtra.Base=CampoExtra.Sufijo
CampoExtra.Sufijo=CampoExtra.Nombre
CampoExtra.Nombre=CampoExtra.Mascara
CampoExtra.Mascara=CampoExtra.AyudaTipo
CampoExtra.AyudaTipo=CampoExtra.AyudaReferencia
CampoExtra.AyudaReferencia=CampoExtra.ValidacionTipo
CampoExtra.ValidacionTipo=CampoExtra.ValidacionTabla
CampoExtra.ValidacionTabla=CampoExtra.ValidacionCampo
CampoExtra.ValidacionCampo=CampoExtra.ValidacionReferencia
CampoExtra.ValidacionReferencia=(Fin)
